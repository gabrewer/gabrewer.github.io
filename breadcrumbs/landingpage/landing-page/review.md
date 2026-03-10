# Review Report — landingpage/landing-page (Greg's Decisions Round)

**Who**: Review Agent
**Date**: 2026-03-10
**Prior review**: `breadcrumbs/landingpage/scaffolddesign-explorationlanding-pageabout-pageblog-migrationpolish/review.md`
**Build status after fixes**: PASS — 103 pages, zero errors

---

## Context

Greg reviewed the escalated items from the previous sprint review and provided decisions on all 6 items. This report tracks the implementation of those decisions.

---

## Resolved

### [WARN-3] Fixed — 75 link roundup files renamed to `YYYY-MM-DD.md` format
**Greg's decision**: "let's go with the recommendation of renaming the files to `YYYY-MM-DD.md` format"
**What was done**:
- Wrote a Python rename script that parsed each `links-{M}-slash-{D}-slash-{YYYY}.md` filename, extracted month/day/year, and renamed all 75 files to `{YYYY}-{MM}-{DD}.md` (zero-padded)
- No conflicts — all 75 files had unique dates
- New URLs are clean ISO-date slugs: `/links/2024-10-10/`, `/links/2023-07-08/`, etc.
- The dynamic `post.slug` in `[...slug].astro` derives from the filename automatically — no template changes required
- Also updated `links/[...slug].astro` breadcrumb to link back to `/links` (was incorrectly pointing to `/blog`) and fixed the "All posts" footer link to say "All link roundups" and point to `/links`
**Confidence**: High

---

### [INFO-2] Fixed — Created `/links.xml` separate RSS feed
**Greg's decision**: "Separate feed — create a second feed at `/links.xml` for link roundups only"
**What was done**:
- Created `src/pages/links.xml.ts` — mirrors the structure of `rss.xml.ts` but uses `getCollection('links')`
- Feed title: "Greg Brewer — Link Roundups"
- Feed description explains the curated links purpose
- All 75 link roundup posts included, sorted by date descending
- Each item links to `/links/{slug}/`
- The original `/rss.xml` (blog posts only) is unchanged
**Confidence**: High

---

### [INFO-4] Fixed — Link roundups removed from blog index; blog shows only original writing
**Greg's decision**: "the blog page should not have the link roundups. they should be in a separate page."
**What was done**:
- Rewrote `src/pages/blog/index.astro` to only call `getCollection('blog')` — the `links` collection is no longer fetched or rendered here
- Removed the type legend (Post / Links badges) — no longer needed
- Updated header text to reflect blog-posts-only count
- Added a contextual note: "Looking for curated links? See the Link Roundups archive." with a link to `/links`
- The `/links/` index page (created in prior review) remains unchanged and continues to show all 75 roundups
**Confidence**: High

---

### [WARN-6] Fixed — Design options B and C built; comparison index at `/designs`
**Greg's decision**: "the design is too basic, i need more options"
**What was done**:
- Created `src/pages/designs/index.astro` — comparison index with three cards describing each layout approach; Option A links to `/` (the live page)
- Created `src/pages/designs/option-b.astro` — **Editorial / Magazine** layout:
  - Left-aligned masthead: avatar inline with name/title; status pill floats right on desktop
  - Asymmetric 2/3 + 1/3 grid: main column (latest writing with featured-post card, speaking section) and sidebar (Lessi AI bordered panel, connect CTA buttons)
  - Newspaper-style typography: `font-black` headings, `uppercase tracking-tight` section labels, `text-3xl` featured post vs compact list for the rest
  - Feels like someone who writes and thinks publicly
- Created `src/pages/designs/option-c.astro` — **Dashboard / Builder's Workbench** layout:
  - Full-width DaisyUI `stats` strip: "30+ years / experience", "Co-Founder & CTO / Lessi AI", "AI Systems / Agentic coding", "UMich / EECS 441 Guest Lecturer"
  - Dominant full-width Lessi AI `bg-primary` hero card with CTA
  - 3-col (desktop) / 2-col (tablet) / 1-col (mobile) card grid: Identity, Latest Writing, Speaking, Technical Focus (badge clusters), Connect
  - Information visible at a glance; flat and organized
- All three options use `BaseLayout` directly (nav + all 14 themes via ThemeSwitcher included automatically)
- All use exclusively DaisyUI semantic color tokens — no hardcoded colors
**Confidence**: High

---

### [INFO-1] Confirmed — Email address is correct, no action needed
**Greg's decision**: "this is the correct email address"
**What was done**: No code changes. `greg@gabrewer.com` confirmed as the correct contact address for all mailto links.
**Confidence**: High

---

### [INFO-5] Deferred — Greg will add blog post descriptions manually
**Greg's decision**: "I will add descriptions"
**What was done**: No code changes. Greg will add `description:` frontmatter to each of the 23 blog posts. The code correctly falls back to `post.data.title` in the meantime.
**Confidence**: High

---

## Dismissed

No new dismissals in this round.

---

## Still Open (no decision yet from Greg)

- **[WARN-5]** Booking URL with `-sdf.` subdomain — Greg has not yet confirmed whether this is the correct production URL. Recommend verifying before launch.

---

## Verification

- Build status: **PASS**
- Pages generated: **106** (up from 103 — new: `/designs/index.html`, `/designs/option-b/index.html`, `/designs/option-c/index.html`)
- Clean ISO-date URLs for link roundups: **yes** — `/links/2024-10-10/` etc.
- `/links.xml` feed generated: **yes**
- Blog index shows only blog posts: **yes**
- Design options B and C: **yes** — live at `/designs/option-b` and `/designs/option-c`

---

## Breadcrumb

- **Who**: Review Agent
- **What**: Implemented all 5 of Greg's concrete decisions from escalated.md; confirmed 1; deferred 1 (Greg's own content work); launched frontend-builder for new design options
- **Why**: WARN-3 and INFO-4 were mechanical renames/restructuring. INFO-2 was a new file. WARN-6 required creative design work delegated to the frontend-builder. INFO-1 and INFO-5 required no code changes.
- **Confidence**: High
