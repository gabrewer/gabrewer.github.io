#!/usr/bin/env bash
set -euo pipefail

###############################################################################
# Team Lead / Coordinator
#
# The brain of the operation. Reads the Sprint plan and orchestrates all agents
# through the execution flow defined in TEAM-ARCHITECTURE.md:
#
#   Phase 1: Planning    — PM Agent reads PRD, produces Sprint plan
#   Phase 2: Per-Sprint  — Build → Destroy → Review & Resolve → Commit
#   Phase 3: Briefing    — Generate summary from breadcrumbs
#
# All artifacts use the {feature}/{sprint-name} naming convention.
# Starts conservative (sequential execution, no overlap between phases).
#
# Usage:
#   ./scripts/build.sh landingpage                        # Full run
#   ./scripts/build.sh landingpage --from scaffold        # Resume from sprint
#   ./scripts/build.sh landingpage --only blog-migration  # Run one sprint
#   ./scripts/build.sh landingpage --plan-only            # Only planning phase
#   ./scripts/build.sh landingpage --dry-run              # Preview
###############################################################################

# ── Args ─────────────────────────────────────────────────────────────────────

if [[ $# -lt 1 ]] || [[ "$1" == --* ]]; then
  echo "Usage: $0 <feature-name> [options]"
  echo ""
  echo "  <feature-name>           Required. e.g. 'landingpage'"
  echo "  --from <sprint-slug>     Resume from a specific sprint"
  echo "  --only <sprint-slug>     Run only one sprint"
  echo "  --plan-only              Only run Phase 1 (planning)"
  echo "  --dry-run                Print what would run"
  exit 1
fi

FEATURE="$1"; shift

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG_DIR="$PROJECT_DIR/logs/${FEATURE}"
BREADCRUMB_DIR="$PROJECT_DIR/breadcrumbs/${FEATURE}"
SPRINT_DIR="$PROJECT_DIR/sprints/${FEATURE}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
MASTER_LOG="$LOG_DIR/build_${TIMESTAMP}.log"
MAX_TURNS=200
FROM_SPRINT=""
ONLY_SPRINT=""
PLAN_ONLY=false
DRY_RUN=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --from) FROM_SPRINT="$2"; shift 2 ;;
    --only) ONLY_SPRINT="$2"; shift 2 ;;
    --plan-only) PLAN_ONLY=true; shift ;;
    --dry-run) DRY_RUN=true; shift ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

mkdir -p "$LOG_DIR" "$BREADCRUMB_DIR" "$SPRINT_DIR"

###############################################################################
# Logging
###############################################################################

log() {
  local level="$1"; shift
  local ts
  ts=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$ts] [$level] $*" | tee -a "$MASTER_LOG"
}

banner() {
  echo "" | tee -a "$MASTER_LOG"
  echo "================================================================" | tee -a "$MASTER_LOG"
  echo "  $*" | tee -a "$MASTER_LOG"
  echo "================================================================" | tee -a "$MASTER_LOG"
  echo "" | tee -a "$MASTER_LOG"
}

###############################################################################
# Git
###############################################################################

git_init_if_needed() {
  cd "$PROJECT_DIR"
  if [[ ! -d .git ]]; then
    git init
    git checkout -b main
    cat > .gitignore << 'EOF'
node_modules/
dist/
.astro/
.DS_Store
EOF
    git add -A
    git commit -m "$(cat <<'MSG'
Initial commit — project files

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
MSG
)"
    log "INFO" "Initialized git repository"
  fi
}

git_commit() {
  local sprint_slug="$1"
  local phase="$2"  # build, review, or plan
  cd "$PROJECT_DIR"

  if [[ -z $(git status --porcelain) ]]; then
    log "INFO" "No changes to commit (${FEATURE}/${sprint_slug} / ${phase})"
    return 0
  fi

  local msg
  case "$phase" in
    plan)   msg="chore(${FEATURE}): sprint plan generated from PRD" ;;
    build)  msg="feat(${FEATURE}/${sprint_slug}): build complete" ;;
    review) msg="fix(${FEATURE}/${sprint_slug}): review fixes applied" ;;
  esac

  git add -A
  git commit -m "$(cat <<EOF
${msg}

Feature: ${FEATURE}
Sprint: ${sprint_slug}
Phase: ${phase}
Trust level: conservative

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
EOF
)"
  log "INFO" "Committed: $msg"
}

###############################################################################
# Agent runner
###############################################################################

run_agent() {
  local agent_name="$1"
  local prompt="$2"
  local log_file="$3"
  local description="$4"

  log "INFO" "Agent: $agent_name — $description"

  if $DRY_RUN; then
    log "DRY-RUN" "Would run: claude --agent $agent_name -p '${prompt:0:100}...'"
    return 0
  fi

  local start_time=$SECONDS

  cd "$PROJECT_DIR"
  claude --agent "$agent_name" \
    -p "$prompt" \
    --max-turns "$MAX_TURNS" \
    --dangerously-skip-permissions \
    --output-format text \
    > "$log_file" 2>&1 || {
      local exit_code=$?
      log "ERROR" "Agent $agent_name failed (exit $exit_code) — see $log_file"
      return $exit_code
    }

  local duration=$(( SECONDS - start_time ))
  log "INFO" "Agent $agent_name completed in ${duration}s"
}

###############################################################################
# Phase 1: Planning
###############################################################################

phase_planning() {
  banner "PHASE 1: PLANNING — ${FEATURE}"

  run_agent "pm" \
    "The feature name is: ${FEATURE}

Read the PRD at PRD.md, the team architecture at TEAM-ARCHITECTURE.md, and the personal info at personal-info.md. Also examine the existing 11ty blog at /home/gabrewer/source/gabrewer.github.io/ to understand the migration scope (24 blog posts in posts/, 76 link roundups in useful_links/, partial Astro migration already in src/content/blog/).

Produce a Sprint plan using the {feature}/{sprint-name} naming convention. Feature name is '${FEATURE}'. Generate sprint slugs like 'scaffold', 'design-exploration', 'landing-page', etc.

Write the plan to sprints/${FEATURE}/plan.md.
Write breadcrumbs to breadcrumbs/${FEATURE}/planning/pm.md.

Remember: this is a static Astro site with Tailwind CSS 4 + DaisyUI 5, hosted on GitHub Pages. There is no backend or API layer — skip Domain Modeler and API Developer phases. Every Sprint must leave the project in a buildable state." \
    "$LOG_DIR/phase1_planning_${TIMESTAMP}.log" \
    "Generate Sprint plan from PRD"

  git_commit "planning" "plan"
}

###############################################################################
# Phase 2: Per-Sprint Execution
###############################################################################

# Parse sprint slugs from plan.md
get_sprint_slugs() {
  if [[ ! -f "$SPRINT_DIR/plan.md" ]]; then
    log "ERROR" "Sprint plan not found at $SPRINT_DIR/plan.md"
    exit 1
  fi
  grep '^## Sprint: ' "$SPRINT_DIR/plan.md" | sed 's/^## Sprint: //' | tr -d '[:space:]' || true
}

should_run_sprint() {
  local slug="$1"

  # --only mode: only run the named sprint
  if [[ -n "$ONLY_SPRINT" ]]; then
    [[ "$slug" == "$ONLY_SPRINT" ]]
    return
  fi

  # --from mode: skip until we hit the target, then run everything after
  if [[ -n "$FROM_SPRINT" ]]; then
    # Check if we've seen the from-sprint yet
    if [[ "$slug" == "$FROM_SPRINT" ]]; then
      # Mark that we've found it (use a file flag since we're in a subshell)
      touch "$LOG_DIR/.from_sprint_found"
      return 0
    fi
    [[ -f "$LOG_DIR/.from_sprint_found" ]]
    return
  fi

  # Default: run everything
  return 0
}

run_sprint() {
  local sprint_slug="$1"

  banner "SPRINT: ${FEATURE}/${sprint_slug}"

  mkdir -p "$BREADCRUMB_DIR/$sprint_slug"

  # ── Step 1: Build ──────────────────────────────────────────────────────
  log "INFO" "${FEATURE}/${sprint_slug} — Step 1: BUILD"

  run_agent "frontend-builder" \
    "Feature: ${FEATURE}
Sprint: ${sprint_slug}

Read your assigned Tasks from sprints/${FEATURE}/plan.md (look for '## Sprint: ${sprint_slug}').
Read PRD.md and personal-info.md for project context.
Read any existing code in the project to understand current state.

Execute ALL Tasks assigned to you in this Sprint, in dependency order.
For each Task:
1. Read the Task description and acceptance criteria
2. Implement it
3. Verify acceptance criteria are met
4. Run npm run build to confirm the project still builds
5. Leave a breadcrumb in breadcrumbs/${FEATURE}/${sprint_slug}/frontend-builder.md

After completing all Tasks, run npm run build one final time." \
    "$LOG_DIR/${sprint_slug}_build_${TIMESTAMP}.log" \
    "Build ${FEATURE}/${sprint_slug}"

  git_commit "$sprint_slug" "build"

  # ── Step 2: Destroy ────────────────────────────────────────────────────
  log "INFO" "${FEATURE}/${sprint_slug} — Step 2: DESTROY"

  run_agent "destroyer" \
    "Feature: ${FEATURE}
Sprint: ${sprint_slug}

The build phase for ${FEATURE}/${sprint_slug} is complete.

Review all work produced during this Sprint. Read the Sprint plan at sprints/${FEATURE}/plan.md to understand what was supposed to be built. Read the builder breadcrumbs at breadcrumbs/${FEATURE}/${sprint_slug}/frontend-builder.md to see what decisions were made.

Run your full adversarial review. Write findings to breadcrumbs/${FEATURE}/${sprint_slug}/destroyer.md." \
    "$LOG_DIR/${sprint_slug}_destroy_${TIMESTAMP}.log" \
    "Destroy ${FEATURE}/${sprint_slug}"

  # ── Step 3: Review & Resolve ───────────────────────────────────────────
  log "INFO" "${FEATURE}/${sprint_slug} — Step 3: REVIEW & RESOLVE"

  run_agent "reviewer" \
    "Feature: ${FEATURE}
Sprint: ${sprint_slug}

The sprint ${FEATURE}/${sprint_slug} has been through the Destroyer.

Read the Destroyer's report at breadcrumbs/${FEATURE}/${sprint_slug}/destroyer.md.
Read PRD.md for requirements context.
Read sprints/${FEATURE}/plan.md for acceptance criteria.

Triage every finding. Fix what you can, escalate what needs human eyes.
Write resolution report to breadcrumbs/${FEATURE}/${sprint_slug}/review.md.
Write escalated items (if any) to breadcrumbs/${FEATURE}/${sprint_slug}/escalated.md." \
    "$LOG_DIR/${sprint_slug}_review_${TIMESTAMP}.log" \
    "Review ${FEATURE}/${sprint_slug}"

  git_commit "$sprint_slug" "review"

  # ── Sprint Complete ────────────────────────────────────────────────────
  log "INFO" "${FEATURE}/${sprint_slug} — COMPLETE"
}

###############################################################################
# Phase 3: Morning Briefing
###############################################################################

phase_briefing() {
  banner "PHASE 3: MORNING BRIEFING — ${FEATURE}"

  if $DRY_RUN; then
    log "DRY-RUN" "Would generate morning briefing"
    return 0
  fi

  cd "$PROJECT_DIR"

  claude -p "$(cat <<PROMPT
You are the Team Lead generating the morning briefing for feature '${FEATURE}'.

Read ALL files in breadcrumbs/${FEATURE}/ (recursively) and the Sprint plan at sprints/${FEATURE}/plan.md.

Produce a concise briefing covering:

1. **What was done** — Sprints completed, Tasks finished, code produced
2. **Decisions made** — key choices from builder breadcrumbs and their reasoning
3. **Issues encountered** — what the Destroyer found, how it was resolved, and anything escalated
4. **Current state** — what's complete, what's working, build status
5. **Escalated items** — anything in breadcrumbs/${FEATURE}/*/escalated.md that needs human attention

Write the briefing to logs/${FEATURE}/morning-briefing.md.

Also run: git log --oneline and include the commit history in the briefing.
PROMPT
)" \
    --max-turns 30 \
    --dangerously-skip-permissions \
    --output-format text \
    > "$LOG_DIR/phase3_briefing_${TIMESTAMP}.log" 2>&1 || {
      log "WARN" "Briefing generation had issues — check log"
    }

  log "INFO" "Morning briefing written to logs/${FEATURE}/morning-briefing.md"
}

###############################################################################
# Main
###############################################################################

main() {
  banner "TEAM EXECUTION — Feature: ${FEATURE}"
  log "INFO" "Project: $PROJECT_DIR"
  log "INFO" "Feature: $FEATURE"
  log "INFO" "Timestamp: $TIMESTAMP"
  log "INFO" "Trust level: conservative (phased, sequential)"

  cd "$PROJECT_DIR"
  git_init_if_needed

  # Clean up any stale from-sprint flag
  rm -f "$LOG_DIR/.from_sprint_found"

  local overall_start=$SECONDS

  # ── Phase 1: Planning ──────────────────────────────────────────────────
  if [[ -z "$FROM_SPRINT" && -z "$ONLY_SPRINT" ]] || $PLAN_ONLY; then
    phase_planning
  fi

  if $PLAN_ONLY; then
    log "INFO" "Plan-only mode — stopping after Phase 1"
    log "INFO" "Review the Sprint plan at sprints/${FEATURE}/plan.md"
    return 0
  fi

  # ── Phase 2: Sprint Execution ──────────────────────────────────────────
  local sprint_slugs
  sprint_slugs=$(get_sprint_slugs)

  if [[ -z "$sprint_slugs" ]]; then
    log "ERROR" "No sprints found in plan. Run with --plan-only first or check sprints/${FEATURE}/plan.md"
    exit 1
  fi

  local sprint_count
  sprint_count=$(echo "$sprint_slugs" | wc -l | tr -d ' ')
  log "INFO" "Found $sprint_count sprints in plan"

  while IFS= read -r slug; do
    [[ -z "$slug" ]] && continue
    if should_run_sprint "$slug"; then
      run_sprint "$slug"
    else
      log "INFO" "Skipping sprint: ${FEATURE}/${slug}"
    fi
  done <<< "$sprint_slugs"

  # Clean up from-sprint flag
  rm -f "$LOG_DIR/.from_sprint_found"

  # ── Phase 3: Briefing ─────────────────────────────────────────────────
  phase_briefing

  # ── Done ───────────────────────────────────────────────────────────────
  local total_duration=$(( SECONDS - overall_start ))
  local minutes=$(( total_duration / 60 ))
  local seconds=$(( total_duration % 60 ))

  banner "BUILD COMPLETE — ${FEATURE}"
  log "INFO" "Total time: ${minutes}m ${seconds}s"
  log "INFO" "Master log: $MASTER_LOG"

  echo ""
  echo "Artifacts:"
  echo "  Sprint plan:      sprints/${FEATURE}/plan.md"
  echo "  Morning briefing: logs/${FEATURE}/morning-briefing.md"
  echo "  Master log:       $MASTER_LOG"
  echo ""
  echo "Breadcrumbs:"
  find "$BREADCRUMB_DIR" -name "*.md" -type f 2>/dev/null | sort | while read -r f; do
    echo "  ${f#$PROJECT_DIR/}"
  done
  echo ""
  echo "Escalated (needs human review):"
  local escalated_files
  escalated_files=$(find "$BREADCRUMB_DIR" -name "escalated.md" -type f 2>/dev/null)
  if [[ -n "$escalated_files" ]]; then
    echo "$escalated_files" | while read -r f; do
      echo "  ${f#$PROJECT_DIR/}"
    done
  else
    echo "  (none)"
  fi
  echo ""
  echo "Git log:"
  git log --oneline -15
}

main
