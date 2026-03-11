---
name: refine
description: Apply a small interactive change with full discipline — edit, verify, destroy, breadcrumb, commit. Use when making targeted refinements to the site.
disable-model-invocation: false
argument-hint: "[description of the change]"
---

You are executing the /refine skill. This is the interactive counterpart to the unattended build pipeline. It applies the SAME discipline as the full sprint cycle but scoped to a single change.

## The Rules — No Exceptions

Every /refine invocation follows ALL five steps in order. You do NOT skip steps. You do NOT combine steps. You do NOT decide a step is unnecessary. If you skip the breadcrumb step, you have failed.

## Input

The change request: $ARGUMENTS

Feature context: Read `PRD.md` for project requirements. Read `TEAM-ARCHITECTURE.md` for the team protocol. Check recent breadcrumbs in `breadcrumbs/` for prior decisions.

## Step 1: EDIT

1. Read the files you need to change
2. Make the edits
3. Run `npm run build` to verify the build passes
4. If the build fails, fix it before moving on

## Step 2: VERIFY

1. Run `npm run build` (if you didn't already in Step 1)
2. Check that your changes work as intended
3. Briefly review adjacent code to make sure you didn't break anything

## Step 3: DESTROY (targeted)

Perform a targeted adversarial review of ONLY the files you changed. Check for:
- Hardcoded colors (should use DaisyUI semantic classes)
- Accessibility issues (aria attributes, alt text, heading hierarchy)
- Broken links or references
- Theme compatibility (will this look right across themes?)
- Anything the change might have broken in related components

Report findings. If you find issues, fix them and re-verify.

## Step 4: BREADCRUMB (mandatory — do NOT skip this)

Determine the feature and sprint context from the most recent breadcrumbs or git log. Append to the appropriate breadcrumb file at `breadcrumbs/{feature}/{sprint-name}/refinements.md`. If no sprint context exists, use `breadcrumbs/{feature}/interactive/refinements.md`.

Create the directory if it doesn't exist.

Use this exact format:

```markdown
### Refinement: {short title}
- **Date**: {today's date}
- **Who**: Frontend Builder (interactive)
- **What**: {what was changed}
- **Why**: {why — include Greg's reasoning if he gave it}
- **Files changed**: {list of files}
- **Alternatives considered**: {what else was discussed, if anything}
- **Confidence**: high | medium | low
```

## Step 5: COMMIT

Stage the changed files (including the breadcrumb file) and commit with:

```
refine({feature}/{sprint}): {short description}

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
```

## After All Steps

Tell Greg what was done, what the targeted destroy found (if anything), and confirm the commit.
