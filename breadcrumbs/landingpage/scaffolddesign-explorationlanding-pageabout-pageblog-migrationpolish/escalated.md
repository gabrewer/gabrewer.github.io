# Escalated Items — landingpage/scaffolddesign-explorationlanding-pageabout-pageblog-migrationpolish

**Who**: Review Agent
**Date**: 2026-03-05 (updated 2026-03-10)

These items require human input or Greg's decision before they can be resolved. None block the build. None have been touched by automated fixes.

---

## [WARN-3] ✅ RESOLVED — Link roundup URLs renamed to ISO date format

**Status**: RESOLVED 2026-03-10
**Greg's decision**: "let's go with the recommendation of renaming the files to `YYYY-MM-DD.md` format"
**What was done**: All 75 files in `src/content/links/` renamed from `links-{M}-slash-{D}-slash-{YYYY}.md` to `{YYYY}-{MM}-{DD}.md` (zero-padded). URLs are now clean: `/links/2024-10-10/`, `/links/2023-07-08/`, etc. Build verified: PASS.

---

## [WARN-6] ✅ RESOLVED (pending Greg's final pick) — Design options B and C built

**Status**: RESOLVED 2026-03-10 — awaiting Greg's selection
**Greg's decision**: "the design is too basic, i need more options"
**What was done**:
- `/designs` — Comparison index with all three options described and linked
- `/designs/option-b` — Editorial/magazine: asymmetric 2/3+1/3 grid, featured post card, writing-forward typography, left-aligned identity block
- `/designs/option-c` — Dashboard: DaisyUI stats strip, dominant Lessi AI hero card, 3-col card grid (Identity, Writing, Speaking, Tech Focus, Connect)
- All three support all 14 DaisyUI themes; all use `BaseLayout` (nav + theme switcher included)
- Build verified: PASS — 106 pages

**Next step for Greg**: Visit `/designs` to compare all three layouts side-by-side with the theme switcher. Select Option A (current `/`), B, or C — or describe a hybrid. Once a direction is confirmed, the chosen layout becomes the live landing page at `/`.

---

## [INFO-1] ✅ RESOLVED — Contact email confirmed

**Status**: RESOLVED 2026-03-10
**Greg's decision**: "this is the correct email address"
**What was done**: No code changes needed. `greg@gabrewer.com` confirmed correct for all mailto links.

---

## [INFO-2] ✅ RESOLVED — Created separate `/links.xml` RSS feed

**Status**: RESOLVED 2026-03-10
**Greg's decision**: "Separate feed — create a second feed at `/links.xml` for link roundups only"
**What was done**: Created `src/pages/links.xml.ts` with all 75 link roundup posts. The existing `/rss.xml` (blog posts only) is unchanged. Build verified: PASS — `/links.xml` generated correctly.

---

## [INFO-4] ✅ RESOLVED — Link roundups removed from blog index

**Status**: RESOLVED 2026-03-10
**Greg's decision**: "the blog page should not have the link roundups. they should be in a separate page."
**What was done**: Rewrote `src/pages/blog/index.astro` to show only blog posts (23 posts). Added a contextual link to the `/links` archive for readers looking for roundups. The `/links/` index page (from the previous review) continues to serve the 75 roundups. Build verified: PASS.

---

## [INFO-5] ⏳ DEFERRED — Greg will add blog post descriptions

**Status**: DEFERRED 2026-03-10
**Greg's decision**: "I will add descriptions"
**What was done**: No code changes. Greg will add `description:` frontmatter fields to the 23 blog posts in `src/content/blog/`. The fallback (`"Post Title by Greg Brewer"`) remains in place until descriptions are added. No build change needed.

---

## Still open (no decision provided)

### [WARN-5] Booking URL uses `-sdf.` subdomain — possible staging endpoint
**Status**: Still open — no decision from Greg yet
**Affected files**: `src/components/landing/Connect.astro:3`, `src/pages/about.astro:223`
**Current value**: `https://outlook-sdf.office.com/bookwithme/...`
**Action needed**: Greg should click the booking link and confirm it works for real visitors. If it's a staging URL, replace with `https://outlook.office.com/bookwithme/...`.
