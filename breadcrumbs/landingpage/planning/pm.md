# PM Breadcrumbs — landingpage

## Decision: Sprint Structure (6 Sprints)

- **Who**: PM Agent
- **What**: Decomposed the PRD into 6 sprints: scaffold, design-exploration, landing-page, about-page, blog-migration, polish
- **Why**: Follows the PRD's milestone structure closely (Milestones 0-5) but splits them to keep each sprint independently committable. The about-page is its own sprint because it's a standalone page with no dependencies on blog content. Blog migration is a single large sprint because the tasks are tightly coupled (collection setup -> content migration -> page templates -> index -> dynamic landing page integration).
- **Alternatives considered**:
  - Combining about-page into landing-page sprint — rejected because it would make the sprint too large for single-agent tasks
  - Splitting blog-migration into two sprints (content migration + page templates) — rejected because the intermediate state (content exists but no pages render it) isn't useful
  - Putting design-exploration after scaffold as a separate review gate — this is what we did, matching PRD Milestone 0
- **Confidence**: high

## Decision: Separate Content Collection for Useful Links

- **Who**: PM Agent
- **What**: Created a separate `links` content collection for the 75 useful_links roundup posts, rather than mixing them into the `blog` collection
- **Why**: The useful_links are structurally different content (link roundups vs. original blog posts). They have different frontmatter (`tags: links` vs `tags: post`), different visual treatment on the landing page (excluded from "Latest Posts"), and the PRD's "Latest Blog Posts" section specifically shows blog posts, not link roundups. Keeping them separate enables different rendering and filtering.
- **Alternatives considered**:
  - Single `blog` collection with a `type` field to distinguish — simpler but harder to query and filter
  - Excluding useful_links entirely — the PRD says "all existing posts preserved" which likely includes these
- **Confidence**: medium — flagged as ambiguity for Greg to confirm

## Decision: Design Exploration as Working Astro Pages

- **Who**: PM Agent
- **What**: Design options built as real Astro pages at `/designs/option-a`, `/designs/option-b`, `/designs/option-c` rather than separate HTML files or Figma mockups
- **Why**: PRD Milestone 0 says "3 distinct layout/design options... each as a working HTML prototype rendered in the browser." Building them as Astro pages means they use real DaisyUI components and the actual theme switcher, giving Greg an accurate preview. They're cleaned up after selection.
- **Alternatives considered**:
  - Static HTML files outside Astro — wouldn't demonstrate theme switching accurately
  - Building in a separate branch — adds git complexity for no benefit
- **Confidence**: high

## Decision: Blocking Gate Between Design Exploration and Landing Page

- **Who**: PM Agent
- **What**: Sprint `landing-page` has an explicit blocker requiring Greg's design selection before work begins
- **Why**: PRD Milestone 0 states "Greg selects one (or a hybrid) before moving to Milestone 1." Building the landing page without this selection would mean guessing, which violates the PM Agent's core principle.
- **Alternatives considered**:
  - Defaulting to Option A if no response — violates "never guess" principle
  - Building all three as production-ready and letting Greg switch later — too much wasted work
- **Confidence**: high

## Decision: URL Preservation Flagged But Not Prescribed

- **Who**: PM Agent
- **What**: Flagged the 11ty-to-Astro URL mismatch as an ambiguity rather than prescribing a solution
- **Why**: 11ty URLs are `/YYYY/MM/slug/` while Astro defaults to `/blog/slug/`. The PRD says "URL structure should be preserved where possible." The builder needs flexibility to choose between matching the old URL pattern via dynamic routes or implementing redirects. This is an implementation detail best decided by the builder with Greg's confirmation.
- **Alternatives considered**:
  - Prescribing exact URL pattern — too implementation-specific for the PM layer
  - Ignoring the issue — would break existing links, violating PRD requirement
- **Confidence**: medium

## Decision: Task Sizing for Single-Agent Invocations

- **Who**: PM Agent
- **What**: Kept each task small enough for a single agent invocation. The largest task is `migrate-useful-links` (75 files) which is primarily a copy+adjust operation. Design option tasks are larger but self-contained.
- **Why**: Project instructions state "Tasks should be small enough that a single agent invocation can complete them." Each task produces a testable, buildable increment.
- **Alternatives considered**:
  - Splitting design options into content + layout tasks — too granular, the design must be evaluated holistically
  - Combining migrate-blog-posts and migrate-useful-links — too large, 98 files total
- **Confidence**: high

## Decision: Skip Domain Modeler and API Developer Phases

- **Who**: PM Agent
- **What**: No domain modeling or API contract tasks in the plan
- **Why**: This is a static Astro site with no backend, no API layer, and no database. The TEAM-ARCHITECTURE.md defines these phases, but the user explicitly instructed to skip them. Content collections serve as the "data model" and are handled in the blog-migration sprint.
- **Alternatives considered**: None — clear instruction from the user
- **Confidence**: high

## Audit: Existing 11ty Blog State

- **Who**: PM Agent
- **What**: Audited the existing blog at `/home/gabrewer/source/gabrewer.github.io/`
- **Why**: PRD Open Question #1 required this audit before planning migration tasks
- **Findings**:
  - **23 blog posts** in `posts/` (2012-2023, mostly .NET/web dev topics)
  - **75 useful_links roundup posts** in `useful_links/` (2014-2024, curated link collections)
  - **Partial Astro migration** already done: all 23 blog posts copied to `src/content/blog/` with adjusted frontmatter (tags as arrays)
  - **11ty frontmatter**: title, date, author, comments, categories (array), tags (string "post" or "links")
  - **Astro migration frontmatter**: same but tags as array `["post"]`
  - **11ty URL pattern**: `/YYYY/MM/slug/` (via posts.json permalink template)
  - **Content collection schema** already defined in `src/content/config.ts`
  - **useful_links NOT yet migrated** to Astro format
  - **Assets**: images in `assets/` directory, referenced from posts
- **Confidence**: high
