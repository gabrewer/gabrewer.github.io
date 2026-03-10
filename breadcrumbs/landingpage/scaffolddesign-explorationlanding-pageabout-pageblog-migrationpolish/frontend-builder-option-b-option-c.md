# Frontend Builder Breadcrumb — Design Options B & C

**Date:** 2026-03-10
**Feature:** landingpage
**Sprint:** scaffolddesign-explorationlanding-pageabout-pageblog-migrationpolish
**Task:** Create Design Option Pages B and C

---

## What was done

Created three new pages under `src/pages/designs/`:

1. `src/pages/designs/index.astro` — comparison index listing all three design options with visual cards and bullet-point descriptions of each layout approach. Option A links to `/` (the live page), B and C link to their respective routes.

2. `src/pages/designs/option-b.astro` — Editorial / Magazine layout. Asymmetric two-column grid (2/3 main content + 1/3 sidebar). Writing section has a newspaper-style header with a featured post card at top, followed by a compact list for remaining posts. Left-aligned masthead with avatar and name inline. Right sidebar contains Lessi AI, Connect, and a background blurb. Strong typographic hierarchy using `font-black`, `uppercase tracking-tight` headings with thick bottom borders.

3. `src/pages/designs/option-c.astro` — Dashboard / Builder's Workbench layout. Stats strip at top using DaisyUI `stats` component (30+ years, Co-Founder/CTO, AI Systems, UMich). Lessi AI as a full-width `bg-primary` featured card below the stats. Remaining sections rendered as a 3-column card grid (2-col on tablet, 1-col mobile): Identity, Latest Writing, Speaking, Technical Focus, Connect. Badge tags used for tech stack rendering.

All three pages use `BaseLayout` (which includes the nav, theme switcher, and footer), so theme switching works out of the box on all three without any additional wiring.

---

## Why these specific structural choices

**Option B — Editorial approach:**
- The 2/3 + 1/3 split was chosen specifically to give writing the majority of horizontal space, consistent with the "newspaper front page" PRD description
- Featured post uses `bg-base-200` with a primary badge — intentionally distinct from the list below it without using hardcoded colors
- Sidebar sections use bordered panels with colored header strips (primary, base-300) to create visual separation and editorial column feel
- The masthead is left-aligned, avatar inline with name — not centered — to match the PRD's "inline/left-aligned identity block" requirement
- Typography contrast achieved with `font-black` vs `text-sm` pairs, `uppercase tracking-widest` for labels, thick `border-b-4 border-base-content` on section headers

**Option C — Dashboard approach:**
- DaisyUI `stats` component was the natural choice for the stats strip — it renders as a horizontal table of figures with no custom CSS needed
- Lessi AI as a full-width primary-background card makes it the most visually dominant element on the page, appropriate for the "featured card, larger" PRD requirement
- Tech stack rendered as badges rather than a list — keeps the card compact and scannable
- Connect card spans `md:col-span-2 lg:col-span-1` to fill the grid properly on tablet where there are two columns

**Both pages:**
- Use `BaseLayout` directly rather than inlining the nav/footer/theme switcher. Simplest possible approach with zero duplication.
- "Back to designs" link at top of each page as required
- All colors are DaisyUI semantic tokens (primary, secondary, accent, base-100/200/300, base-content)
- Blog posts fetched via `getCollection('blog')` — identical pattern to the existing `LatestPosts.astro` component

---

## Alternatives considered

**For Option B sidebar:**
- Considered using DaisyUI `card` components in the sidebar — rejected because the bordered-panel-with-colored-header approach reads more like a print/magazine design element, which better fits the editorial personality
- Considered placing speaking in the sidebar — moved it to the main column because it is content (editorial material), not metadata

**For Option C stats strip:**
- Considered using custom `div` elements with large numbers — used DaisyUI `stats` because it handles the responsive layout and semantic markup automatically, and the visual result matches the "control panel" aesthetic directly
- Considered a 2-column grid only (not 3) — used 3-column on desktop to achieve the "information-dense, see everything at a glance" PRD goal; 2-column on md reduces to avoid cramped cards on tablets

**For the comparison index:**
- Considered a simple bullet list of links — used card components so each option can describe its visual personality inline, making the comparison page itself useful for Greg to understand what he's choosing before clicking

---

## Confidence

**High** — build passes cleanly, all pages render, no hardcoded colors, all DaisyUI semantic tokens used throughout. Structure directly maps to PRD descriptions.
