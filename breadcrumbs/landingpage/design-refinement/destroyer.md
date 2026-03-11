# Destroyer Report — landingpage/design-refinement

**Date**: 2026-03-10
**Destroyer**: Adversarial review of all work produced during the `design-refinement` sprint.

---

## Build Status

✅ `npm run build` **succeeded** — 106 pages, 0 errors, 0 warnings.

---

## Critical (must fix before moving on)

### [CRIT-1] Design exploration pages not cleaned up — published live and indexed in sitemap

**Files**: `src/pages/designs/index.astro`, `src/pages/designs/option-b.astro`, `src/pages/designs/option-c.astro`
**Built output**: `dist/designs/index.html`, `dist/designs/option-b/index.html`, `dist/designs/option-c/index.html`
**Sitemap**: `dist/sitemap-0.xml` contains `https://gabrewer.com/designs/`, `https://gabrewer.com/designs/option-b/`, `https://gabrewer.com/designs/option-c/`

The sprint plan task `landing-page/cleanup-design-pages` explicitly requires: _"Remove the design exploration pages (`src/pages/designs/`) now that the design direction has been selected."_ These pages were **never deleted** and remain in the source, build, and sitemap.

**Why this matters**: When this site deploys, Google will crawl and index three temporary design-exploration pages as real content on `gabrewer.com`. These pages contain:
- Duplicate/near-duplicate content with the main landing page (SEO penalty risk)
- Outdated feature descriptions (see CRIT-2)
- No `noindex` meta tags to protect against crawling
There are no links to these pages from the main nav or any content, so visitors won't find them organically — but Google will.

**Confidence**: High

---

### [CRIT-2] `designs/index.astro` describes Option A with stale content contradicting the design-refinement changes

**File**: `src/pages/designs/index.astro` — line 38
**Built output**: `dist/designs/index.html`

The Option A card reads:
```
<li>Profile photo + name centered at top</li>
```

After this sprint's `hero-rework` task, the Option A design (now `index.astro`) **no longer leads with a profile photo**. The hero leads with the positioning statement, the photo moved to Connect, and the name is secondary. This text is factually wrong about the current live design.

Additionally, the `<p>` description for Option A in `designs/index.astro` (line 32) renders as empty in the built HTML — the description text is missing from the rendered page entirely (Astro likely stripped the paragraph content since the paragraph tag is present but the text node appears lost in the build).

**Why this matters**: If Greg visits `/designs/` to review, the description of Option A will contradict what he sees when he clicks through to `/`. This compounds CRIT-1 — these pages exist, are indexed, and misrepresent the actual live design.

**Confidence**: High

---

## Warnings (should fix)

### [WARN-1] Missing `aria-expanded` on all dropdown trigger buttons

**Files**:
- `src/components/ThemeSwitcher.astro` — line 21 (theme switcher button)
- `src/layouts/BaseLayout.astro` — line 91 (mobile hamburger menu button)

Neither dropdown button has an `aria-expanded` attribute. Screen readers announce dropdowns as "closed" by default and rely on `aria-expanded` toggling to know the current state. DaisyUI's CSS-only dropdown mechanism doesn't toggle this attribute, so screen reader users navigating by keyboard have no way to know whether the dropdown is currently open.

**Why this matters**: WCAG 2.1 SC 4.1.2 requires that UI components expose their states to accessibility APIs. A theme switcher is a core function of this site.

**Confidence**: High

### [WARN-2] `aria-haspopup="true"` should be `aria-haspopup="menu"` on mobile hamburger button

**File**: `src/layouts/BaseLayout.astro` — line 91

```html
<button ... aria-haspopup="true">
```

`aria-haspopup="true"` is the ARIA 1.0 legacy value that maps to `menu`. ARIA 1.1+ expects explicit values. The hamburger dropdown reveals a navigation list, so the correct value is `aria-haspopup="menu"`. The ThemeSwitcher correctly uses `aria-haspopup="listbox"` — the mobile menu button should match the same attention to ARIA role precision.

**Why this matters**: Assistive technology behaviour can differ based on whether `"true"` or `"menu"` is specified. Consistency with the rest of the codebase (`ThemeSwitcher` uses `"listbox"`) also matters.

**Confidence**: High

### [WARN-3] `role="button"` redundant on native `<button>` elements

**Files**:
- `src/components/ThemeSwitcher.astro` — line 23
- `src/layouts/BaseLayout.astro` — line 91

Both locations add `role="button"` to a `<button>` element. This is redundant — native `<button>` elements already have an implicit ARIA role of `button`. Adding it explicitly is harmless but is an antipattern that can mislead future developers into thinking the `role` is required.

**Why this matters**: Code quality / maintenance signal. Not harmful but clutters the markup.

**Confidence**: High

### [WARN-4] LessiFeature full-width section visually floats rather than true full-bleed stripe

**File**: `src/pages/index.astro` — line 15–44

The outer wrapper `<div class="py-16 space-y-16">` uses `space-y-16` (4rem / 64px margin-top on each child) around the `<LessiFeature />` section. This creates visible `bg-base-100` gaps **above and below** the `bg-primary` colored section:

```
[Hero zone]
[4rem base-100 gap ← space-y-16]
[bg-primary section with py-14 internal padding]
[4rem base-100 gap ← space-y-16]
[Speaking/Posts/Connect zone]
```

The builder's stated intent was a "full-width colored block" that creates a "visual peak" and "breaks the monotony of the single-column layout." A true full-bleed stripe would require the `bg-primary` section to start edge-to-edge vertically, without base-100 breathing room above/below. The current implementation creates a floating island on a white/dark canvas, not a stripe.

This may be intentional, but it should be verified against design intent. On certain themes (especially dark themes like `abyss` or `synthwave`) the island effect may look visually disconnected rather than impactful.

**Why this matters**: The design intent ("visual peak") may not be realized as described. Theme-specific visual testing is needed.

**Confidence**: Medium

### [WARN-5] Email address `greg@gabrewer.com` used but PRD Open Question #3 unresolved

**Files**: `src/components/landing/Connect.astro` — line 30; `src/pages/about.astro` — line 221

The PRD explicitly flags the email address as an open question:
> _Open Question #3 — which email for the contact link? Use a placeholder `mailto:` until Greg decides._

The `mailto:greg@gabrewer.com` address appears in two places. This may be Greg's real intended email, or it may have been filled in without explicit confirmation. If this is a Lessi AI email domain, it ties the personal site contact to the company.

**Why this matters**: If this deploys with the wrong email, Greg may miss contact attempts or have his personal domain email exposed unintentionally.

**Confidence**: Medium (likely fine, but needs explicit sign-off)

### [WARN-6] No active navigation state indicator on current page

**File**: `src/layouts/BaseLayout.astro` — lines 82–84, 99–101

The nav links (`Home`, `Blog`, `About`) have no visual active state and no `aria-current="page"` attribute. Visitors cannot see which section of the site they're in. Screen reader users cannot navigate to the "current page" link without scanning all three.

**Why this matters**: WCAG 2.1 SC 2.4.8 (Level AAA) recommends indicating current page. More practically, for a personal site, showing the active nav item is standard UX expected behaviour that's currently absent.

**Confidence**: High

---

## Info (consider addressing)

### [INFO-1] `localStorage` access in anti-flash script has no error handling

**File**: `src/layouts/BaseLayout.astro` — lines 59–67

```javascript
const saved = localStorage.getItem('theme');
```

`localStorage` access can throw in certain environments: iOS Safari private browsing (older versions), cross-origin iframes with strict storage policies, and embedded webviews. If it throws, the entire anti-flash IIFE fails and the page flashes to `light` theme on load.

**Suggestion**: Wrap in try/catch:
```javascript
try {
  const saved = localStorage.getItem('theme');
  // ...
} catch(e) {}
```

**Confidence**: Medium

### [INFO-2] `badge-secondary` on Speaking section label inconsistent with `badge-primary` on type badge

**File**: `src/components/landing/Speaking.astro` — line 15 vs. line 31

The section label "Speaking & Training" uses `badge badge-secondary badge-outline`, while the per-engagement type badge uses `badge-primary`. Within the same component, two different semantic color slots are used. This isn't wrong — it may create intentional hierarchy (secondary for section category, primary for engagement type) — but the visual result is a color surprise within a small component.

The `accent-color-pops` task specified: _"All colors use DaisyUI semantic classes"_ ✅ — this passes. But it's worth verifying the two-color badge hierarchy is intentional and not a leftover from a prior state.

**Confidence**: Low

### [INFO-3] `LessiFeature` "Visit Lessi AI" button uses Tailwind opacity modifiers, not DaisyUI btn modifiers

**File**: `src/components/landing/LessiFeature.astro` — line 43

```html
class="btn btn-sm border-primary-content/60 text-primary-content bg-transparent hover:bg-primary-content/15 hover:border-primary-content"
```

The builder noted this was intentional: _"explicit border/hover classes rather than DaisyUI color modifiers for predictable styling on primary bg."_ The CSS does generate correctly (`hover:bg-primary-content/15` compiles to a `color-mix()` rule). However, the `accent-color-pops` acceptance criterion says _"All colors use DaisyUI semantic classes (no hardcoded colors)"_ — these are DaisyUI semantic tokens but applied via raw Tailwind opacity modifiers, not DaisyUI `btn-*` class modifiers.

This is a judgment call. The colors are semantically correct; the mechanism is Tailwind rather than DaisyUI. Browsers without `color-mix()` support get the non-opaque fallback `var(--color-primary-content)` (solid, not 15% transparent). The button would appear fully opaque on very old browsers.

**Confidence**: Low

### [INFO-4] Designs directory (`/designs/`) reachable but not linked — phantom URLs

**Files**: `src/pages/designs/` (carries over from CRIT-1)

Even ignoring SEO, the `/designs/` pages are navigable by direct URL. Someone who bookmarked these during the design review phase can still access them. Combined with CRIT-2's stale Option A description, this creates a confusing experience for anyone who revisits those URLs.

**Confidence**: High (as a secondary concern to CRIT-1)

---

## What Survived

The following were tested and passed:

- **Build**: `npm run build` completes cleanly — 106 pages, 0 errors, 0 warnings ✅
- **Hero rework**: Positioning statement is the `<h1>` visual headline in `text-primary`, large and bold. Name/title properly secondary. No avatar in hero section. ✅
- **StatusLine pulse dot**: Uses `bg-primary animate-pulse` — correctly using semantic primary color, not `bg-success`. ✅
- **Speaking accent colors**: Institution name `text-primary font-semibold`, topic title `text-accent font-medium`, type badge `badge-primary` — all semantic DaisyUI color tokens. ✅
- **Connect CTAs**: Email `btn-primary`, Book a Call `btn-accent` — dual semantic CTA pattern correctly implemented. ✅
- **LessiFeature colored background**: `bg-primary text-primary-content` — correct semantic color pair. Breaks to `max-w-4xl` content width, wider than the `max-w-2xl` column. Text legibility classes (`/90`, `/80`, `/70` opacity variants) all generate properly in CSS via `color-mix()`. ✅
- **Avatar in Connect**: `w-24 h-24 rounded-full` with `ring-2 ring-primary ring-offset-2 ring-offset-base-100`. `ring-offset-base-100` correctly generates `.ring-offset-base-100 { --tw-ring-offset-color: var(--color-base-100) }` in the CSS. ✅
- **No hardcoded hex/rgb colors** in any component or layout file outside of blog content markdown (which contains legacy inline CSS from old posts — this is migrated content, not new code). ✅
- **No avatar in Hero**: Confirmed absent from `Hero.astro`. ✅
- **Theme system**: All 14 DaisyUI themes configured. Theme switcher works (listbox pattern with correct ARIA roles on the switcher itself). Anti-flash localStorage script present. ✅
- **Heading hierarchy**: Landing page: `h1` (hero positioning statement) → `h2` (Lessi AI, Talks & Training, Latest Writing, Let's Connect). About page: `h1` → multiple `h2` → `h3` within Technical Background. Blog pages: `h1` for post title. No heading skips detected. ✅
- **All SVG icons**: Have `aria-hidden="true"` — they're decorative and correctly hidden from screen readers. ✅
- **LessiFeature `hover:bg-primary-content/15`**: CSS correctly generated as `color-mix(in oklab, var(--color-primary-content) 15%, transparent)` with `var(--color-primary-content)` fallback for unsupported browsers. ✅
- **Meta/SEO**: Title, description, canonical URL, OG tags, Twitter card, RSS link, sitemap link all present in BaseLayout. ✅
- **Responsive design**: Mobile-first Tailwind classes used throughout. `md:text-5xl` on hero, `md:flex` on nav center, `md:hidden` on mobile menu, `flex-wrap` on CTA buttons. ✅
- **ThemeSwitcher ARIA**: `aria-haspopup="listbox"` on trigger, `role="listbox"` on dropdown, `role="option"` + `aria-selected` on items — correct listbox pattern. Active theme highlighted via `bg-primary text-primary-content`. ✅
- **Connect section secondary links**: LinkedIn and GitHub use `btn btn-ghost btn-sm text-primary hover:text-primary` — consistent with the primary color accent language. ✅

---

## Testing Notes

- **Who**: Destroyer (adversarial review)
- **What**: Full source audit of all sprint-modified files (`Hero.astro`, `LessiFeature.astro`, `Speaking.astro`, `StatusLine.astro`, `Connect.astro`, `LatestPosts.astro`, `index.astro`), plus `BaseLayout.astro` and `ThemeSwitcher.astro` for ARIA patterns. Build verification. Sitemap inspection. CSS output verification for generated classes.
- **Why**: Design-refinement sprint changed the visual hierarchy of the landing page. Key risks were: semantic color compliance, full-width breakout behavior, ARIA correctness after layout restructure, and leftover artifacts from prior sprints.
- **NOT tested**: Live Lighthouse audit (requires browser), actual cross-theme visual rendering in browser, localStorage behavior in private mode, keyboard navigation flow end-to-end.
