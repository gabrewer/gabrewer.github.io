# Breadcrumbs — Frontend Builder
## Sprint: design-refinement
## Feature: landingpage
**Date**: 2026-03-10

---

## Task: hero-rework

**Who**: Frontend Builder

**What**: Rewrote `src/components/landing/Hero.astro`. The new layout:
1. Positioning statement ("Exploring ways to apply engineering principles to the AI coding landscape.") as `<h1>` with `text-primary` — large, bold, the visual headline.
2. Greg's name ("Greg Brewer") and title ("Founder · CTO · AI Engineer") as secondary, understated text.
3. Tagline ("I build systems that help people make better decisions.") styled with `text-base-content/60 italic` — present but understated.
4. Removed the avatar/profile photo entirely from this section.

**Why**: The old design led with name + avatar, which is conventional but misses the differentiation opportunity. Leading with the positioning statement immediately signals expertise and unique angle. Visitors scan from top — the most important thing they should read first is what Greg is about, not who he is by name.

**Alternatives considered**:
- Keeping the avatar but moving it to below the positioning statement — rejected because the task spec explicitly moves it to Connect
- Using `text-accent` instead of `text-primary` for the headline — went with `text-primary` as it's more universally well-styled across all 14 themes; accent can be more variable

**Confidence**: High

---

## Task: accent-color-pops

**Who**: Frontend Builder

**What**: Applied strategic accent colors across three components:

1. **StatusLine.astro**: Changed the pulsing dot from `bg-success` to `bg-primary`. Now semantically consistent with the site's primary color rather than the "success/green" association.

2. **Speaking.astro**:
   - Institution name (`University of Michigan`) now `text-primary font-semibold` — the eye-catching anchor for each engagement
   - Topic title now `text-accent font-medium` (removed italic, added semantic accent color) — the most interesting content gets the most visual weight
   - Type badge changed from `badge-ghost` to `badge-primary` — reinforces the connection to the accent system

3. **Connect.astro**:
   - Email button kept as `btn-primary` (already was)
   - Book a Call button changed from `btn-outline` to `btn-accent` — dual primary CTAs now use two distinct semantic colors, creating visual variety and emphasizing both options equally

4. **LatestPosts.astro**: Already had `text-primary` on the "All posts →" link and `group-hover:text-primary` on post titles — no changes needed.

**Why**: The original design used almost no color; everything was `base-content/60` or `base-content/80`. Color was reserved only for `btn-primary` on Email. This made the page feel flat and created no visual anchors. Adding strategic `text-primary` and `text-accent` creates a reading pathway: headline → institution → topic → CTA.

**Alternatives considered**:
- Using `text-accent` for institution instead of `text-primary` — went with `text-primary` for institution (larger, heavier) and `text-accent` for topic (smaller), creating a two-color hierarchy
- Coloring the entire Speaking card border with `border-primary` — rejected as too noisy

**Confidence**: High

---

## Task: lessi-featured-section

**Who**: Frontend Builder

**What**: Redesigned `LessiFeature.astro` as a full-width colored background section using `bg-primary text-primary-content`. Key changes:
- Section is now `w-full` — breaks out of the standard `max-w-2xl` column
- Inner content uses `max-w-4xl mx-auto px-8 py-14` — wider than the rest of the page but still padded
- Text uses `text-primary-content/90` and `text-primary-content/80` for readable opacity hierarchy
- Section label replaces `badge` component with custom inline span (badge colors were unpredictable on primary bg)
- "Visit Lessi AI" button uses explicit border/hover classes rather than DaisyUI color modifiers for predictable styling on primary bg
- Increased font size for the lead paragraph to `text-lg` to match the elevated visual treatment

Restructured `src/pages/index.astro` to enable the full-width breakout:
- Replaced single `max-w-2xl mx-auto px-4 py-16 space-y-16` wrapper with three zones:
  1. Narrow column: `<Hero>` + `<StatusLine>`
  2. Full-width: `<LessiFeature>`
  3. Narrow column: `<Speaking>`, `<LatestPosts>`, `<Connect>`
- `space-y-16` on outer div provides consistent vertical rhythm between zones

**Why**: The Lessi section is Greg's primary proof point — he's actively building in AI, not just advising. It should visually dominate. A full-width colored block creates the "visual peak" the task calls for and breaks the monotony of the single-column layout. The primary color background makes it unmissable while remaining theme-adaptive.

**Alternatives considered**:
- `bg-secondary text-secondary-content` — tested mentally across themes; secondary can be more variable. Primary is more predictable and was pre-tested by DaisyUI theme designers
- `rounded-box` on inner container — rejected because on a full-width section the rounding feels inconsistent at narrow viewports, and the task spec offered it as an alternative to full-width, not both
- `max-w-5xl` inner container — went with `max-w-4xl` for meaningful differentiation from the `max-w-2xl` content without feeling unconstrained

**Confidence**: High

---

## Task: photo-in-connect

**Who**: Frontend Builder

**What**: Added GB initials avatar to `Connect.astro`:
- `w-24 h-24 rounded-full` — larger than the original `w-32 h-32` in Hero... wait, actually the Hero had `w-32 h-32`. The Connect version uses `w-24 h-24` as specified in the task ("w-24 h-24 or similar")
- Same `ring-2 ring-primary ring-offset-2` ring treatment for visual consistency
- Positioned above the section heading and text — the face appears first as the visitor scrolls down, creating a human moment before they read the CTA copy
- `GB` initials placeholder maintained; real photo can replace later by swapping to an `<img>` element

Also updated Connect section:
- LinkedIn and GitHub buttons now `text-primary hover:text-primary` — secondary links get the primary color accent, maintaining consistent color language

**Why**: The Connect section is where decisions get made — "do I reach out to this person?" Placing the photo right there humanizes the moment and creates a micro-connection right when it matters. The original Hero avatar was removed in `hero-rework`, so this fulfills both the removal and the relocation.

**Alternatives considered**:
- Placing avatar beside the heading in a horizontal flex layout — rejected for simplicity; centered avatar above heading works naturally with the centered text layout
- Keeping `w-32 h-32` — kept at `w-24 h-24` per task spec; large enough to be prominent, doesn't overwhelm the connect section

**Confidence**: High

---

## Final Build Verification

**Result**: ✅ `npm run build` succeeded — 106 pages built in 2.29s with no errors or warnings.

All acceptance criteria met across all four tasks:
- Positioning statement is visual headline (`text-primary`, large, bold) ✅
- Name/title clearly secondary ✅
- Tagline present but understated ✅
- No avatar in Hero ✅
- StatusLine dot uses `bg-primary` ✅
- Speaking section: `text-primary` institution, `text-accent` topic, `badge-primary` type ✅
- Connect buttons: `btn-primary` (email) + `btn-accent` (book a call) ✅
- All colors use DaisyUI semantic classes — no hardcoded hex ✅
- LessiFeature has colored background (`bg-primary text-primary-content`) ✅
- LessiFeature breaks out of `max-w-2xl` to full-width with `max-w-4xl` inner ✅
- Text within LessiFeature readable (`text-primary-content` variants) ✅
- Profile avatar in Connect section, `w-24 h-24` ✅
- No avatar remaining in Hero ✅
