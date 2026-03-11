# Review Report — landingpage/design-refinement

**Date**: 2026-03-10
**Reviewer**: Review Agent
**Source**: Destroyer report `breadcrumbs/landingpage/design-refinement/destroyer.md`

---

## Resolved

### [CRIT-1] Fixed — Design exploration pages deleted
- **Action**: Deleted entire `src/pages/designs/` directory (contained `index.astro`, `option-b.astro`, `option-c.astro`)
- **Verification**: `dist/sitemap-0.xml` no longer contains any `/designs/` URLs; page count dropped from 106 → 103 exactly as expected
- **Why**: The sprint plan task `landing-page/cleanup-design-pages` explicitly required this deletion; pages were still live and indexed in the sitemap
- **Confidence**: High

### [CRIT-2] Fixed — Resolved by CRIT-1
- **Action**: Stale `designs/index.astro` content describing Option A with outdated post-hero-rework details is gone because the entire `designs/` directory was deleted
- **Confidence**: High

### [WARN-1] Fixed — `aria-expanded` added to both dropdown trigger buttons
- **ThemeSwitcher.astro**: Added `aria-expanded="false"` to the trigger button; JavaScript now toggles it `true` on open, `false` on close (focusout from dropdown container) and `false` after theme selection
- **BaseLayout.astro (mobile hamburger)**: Added `aria-expanded="false"` to the hamburger button; an `is:inline` script at the bottom of `<body>` toggles it on click and resets it on focusout from the dropdown container
- **Why**: WCAG 2.1 SC 4.1.2 — UI components must expose state to accessibility APIs
- **Confidence**: High

### [WARN-2] Fixed — `aria-haspopup="true"` → `aria-haspopup="menu"` on mobile hamburger
- **File**: `src/layouts/BaseLayout.astro` line 94
- **Why**: ARIA 1.1 requires explicit values; the dropdown reveals a navigation list (`role="menu"`), so `"menu"` is the correct value. Aligns with ThemeSwitcher which already uses the precise `"listbox"` value
- **Confidence**: High

### [WARN-3] Fixed — Redundant `role="button"` removed from both buttons
- **ThemeSwitcher.astro**: Removed `role="button"` from the theme trigger button
- **BaseLayout.astro**: Removed `role="button"` from the mobile hamburger button
- **Why**: Native `<button>` elements have implicit ARIA role `button`; adding it explicitly is an antipattern that clutters markup and misleads future developers
- **Confidence**: High

### [WARN-6] Fixed — Active navigation state added with `aria-current="page"`
- **File**: `src/layouts/BaseLayout.astro`
- **Action**: Added `const pathname = Astro.url.pathname` in frontmatter; all nav links (desktop and mobile) now conditionally set `aria-current="page"` on the active link and apply `text-primary font-semibold` for a visual indicator
- **Logic**: Home (`/`) is exact-match; Blog and About use `startsWith('/blog')` / `startsWith('/about')` to handle sub-pages
- **Why**: Users (sighted and screen reader) need to know which section they're currently in. Addresses WCAG 2.4.8 and basic UX expectations
- **Confidence**: High

### [INFO-1] Fixed — `localStorage` access wrapped in try/catch
- **Files**: `src/layouts/BaseLayout.astro` (anti-flash IIFE) and `src/components/ThemeSwitcher.astro` (theme selection handler)
- **Action**: Both `localStorage.getItem()` and `localStorage.setItem()` calls are now wrapped in try/catch blocks with empty catches
- **Why**: `localStorage` throws in iOS Safari private browsing (older versions), cross-origin iframes, and some embedded WebViews. A silent catch is the correct pattern — the theme simply reverts to default rather than breaking the IIFE
- **Confidence**: High

### [INFO-4] Resolved — Phantom URLs gone
- Resolved as a side-effect of CRIT-1. `/designs/`, `/designs/option-b/`, `/designs/option-c/` no longer exist in the source or build output
- **Confidence**: High

---

## Escalated (needs human review)

See `breadcrumbs/landingpage/design-refinement/escalated.md` for full detail.

### [WARN-4] Escalated — LessiFeature "floating island" vs true full-bleed stripe
- The `bg-primary` LessiFeature section floats with 4rem (`space-y-16`) gaps above and below due to the outer `<div class="py-16 space-y-16">` wrapper on `index.astro`
- The builder stated intent was a "visual peak" and "breaks the monotony of the single-column layout"
- The Destroyer's concern is valid: this creates a floating island effect rather than a true full-bleed stripe, and on certain dark themes (abyss, synthwave) it may look visually disconnected
- This is a **design intent question** — if Greg wants a true edge-to-edge stripe, the fix is to restructure `index.astro` so `<LessiFeature />` sits outside the `space-y-16` wrapper with no top/bottom gap. If the floating island is intentional, no change is needed
- **Escalated because**: Cannot auto-fix without knowing Greg's intent on the visual treatment
- **Confidence**: Medium

### [WARN-5] Escalated — Email address `greg@gabrewer.com` needs explicit sign-off
- PRD Open Question #3: "which email for the contact link?"
- The email `greg@gabrewer.com` appears in `Connect.astro` and `about.astro`
- This may be intentional or it may be the builder's best guess. Either way, since the PRD flagged it as unresolved, Greg should explicitly confirm before the site deploys
- **Escalated because**: Content decision, not a code issue. If wrong email, Greg misses real contacts
- **Confidence**: Medium

---

## Dismissed

### [INFO-2] Dismissed — Two-tone badge hierarchy in Speaking.astro is likely intentional
- `badge-secondary` on the section label "Speaking & Training" vs `badge-primary` on the per-engagement type badge
- The `accent-color-pops` sprint task acceptance criterion is met (`All colors use DaisyUI semantic classes` ✅)
- Using secondary for section category and primary for engagement type is a reasonable visual hierarchy choice — secondary is quieter, primary is more assertive for the per-item type label
- There is no evidence this is a mistake; no hardcoded colors are involved
- **Why dismissed**: Low confidence finding, consistent with semantic color usage, likely intentional hierarchy
- **Confidence**: Low — no action needed

### [INFO-3] Dismissed — LessiFeature button uses Tailwind opacity modifiers, not DaisyUI btn modifiers
- `class="btn btn-sm border-primary-content/60 text-primary-content bg-transparent hover:bg-primary-content/15 hover:border-primary-content"`
- The builder explicitly noted this was intentional for predictable styling on a `bg-primary` background
- The colors ARE semantically correct (DaisyUI tokens `primary-content`); only the mechanism differs (Tailwind opacity modifiers vs. DaisyUI `btn-*` class)
- CSS output for `color-mix()` is verified correct by the Destroyer; the old-browser fallback to solid `var(--color-primary-content)` is acceptable
- The acceptance criterion says "no hardcoded colors" — this passes. No DaisyUI `btn-*` variant for a ghost-on-primary-bg button exists that would cover this case better
- **Why dismissed**: Builder intent was explicit; technically correct; no better DaisyUI alternative for this specific use case
- **Confidence**: Low — no action needed

---

## Verification

- **Build status**: ✅ PASS — `npm run build` succeeded, 103 pages, 0 errors, 0 warnings
- **Pages removed**: 106 → 103 (exactly the 3 deleted designs pages)
- **Sitemap verified**: No `/designs/` URLs in `dist/sitemap-0.xml`
- **All critical fixes verified**: Yes
- **All warning fixes verified**: Yes (WARN-1, WARN-2, WARN-3, WARN-6 directly edited; WARN-4 and WARN-5 escalated)
- **Info fixes verified**: INFO-1 fixed; INFO-2 and INFO-3 dismissed with rationale; INFO-4 resolved by CRIT-1

---

## Breadcrumb

- **Who**: Review Agent
- **What**: Triaged 2 criticals, 6 warnings, 4 info items from Destroyer report
- **Why**: Destroyer caught real issues (undeleted design pages, ARIA gaps, missing active nav state); all fixable items addressed directly; design and content decisions escalated
- **Confidence**: High on all fixes; Medium on escalated items (require owner decision)
