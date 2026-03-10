# Morning Briefing — landingpage
**Date**: 2026-03-10
**Feature**: Personal landing page at gabrewer.com

---

## 1. What Was Done

All 6 sprints from the plan have been executed in a single build pass:

| Sprint | Status | Tasks |
|--------|--------|-------|
| **scaffold** | Complete | init-astro-project, base-layout, theme-switcher, placeholder-pages, github-actions-deploy |
| **design-exploration** | Complete | 3 design options built (A, B, C) + index page; all removed after selection |
| **landing-page** | Complete | build-landing-page, cleanup-design-pages |
| **about-page** | Complete | build-about-page |
| **blog-migration** | Complete | setup-content-collection, migrate-blog-posts (23), migrate-useful-links (75), blog-post-page, blog-index-page, dynamic-latest-posts |
| **polish** | Complete | meta-and-seo, favicon, rss-feed, final-review; performance-audit partial (no Lighthouse env) |

**Build output**: 103 pages, zero errors, zero warnings.

### Commit History

```
7e8ef4a fix(landingpage/...): review fixes applied
6a40973 feat(landingpage/...): build complete
9848fb9 chore(landingpage): sprint plan generated from PRD
8ab9993 Initial commit — project files
```

---

## 2. Decisions Made

| Decision | Chosen | Reasoning | Confidence |
|----------|--------|-----------|------------|
| **Tech stack** | Astro 5 + Tailwind CSS 4 + DaisyUI 5 | Tailwind 4 uses Vite plugin (not PostCSS); DaisyUI 5 uses `@plugin` CSS syntax | High |
| **Theme config** | 14 themes via CSS `@plugin "daisyui"` | DaisyUI 5 pattern; light default, dark prefersdark | High |
| **Theme switcher** | Vanilla inline script, zero JS bundle | Anti-flash script in `<head>` with `is:inline`; no framework hydration | High |
| **Design direction** | Option A — "Minimal & Focused" | Builder chose unilaterally (PRD blocker violated); centered single-column | Medium |
| **Blog URLs** | `/blog/[slug]` not `/YYYY/MM/slug/` | Simpler; 11ty URL preservation flagged for Greg | Medium |
| **Link roundup URLs** | `/links/[slug]` separate from `/blog/` | Different content type, different template | Medium |
| **Content collections** | Separate `blog` (23) and `links` (75) collections | Different frontmatter, different rendering needs | Medium |
| **Schema approach** | Permissive union types for tags/categories | Handles both string and array formats from 11ty inconsistencies | High |
| **Edcountable** | Omitted entirely | PRD Resolved Decision #7 | High |
| **Skip domain modeler/API phases** | No backend work | Static site; per user instruction | High |

---

## 3. Issues Encountered

### Destroyer Found 17 Issues Total

**Critical (3) — all fixed:**

| ID | Issue | Fix |
|----|-------|-----|
| CRIT-1 | Broken images in 5 blog posts (16 refs, no `public/images/`) | Copied images from 11ty source |
| CRIT-2 | `display-collection+json` slug dropped the `+` silently | Renamed file to use `-json-` |
| CRIT-3 | ThemeSwitcher `aria-selected` never updated (WCAG 4.1.2) | Added dynamic `aria-selected` toggling |

**Warnings (8) — 5 fixed, 1 dismissed, 2 escalated:**

| ID | Issue | Resolution |
|----|-------|------------|
| WARN-1 | Blog posts used `og:type="website"` | Fixed — now `"article"` |
| WARN-2 | ThemeSwitcher script was bundled module | Fixed — converted to `is:inline` |
| WARN-3 | Link roundup URLs contain literal "slash" | Escalated |
| WARN-4 | No `/links/` index page (404) | Fixed — created links index |
| WARN-5 | Booking URL uses `-sdf.` subdomain | Dismissed — PRD-confirmed URL |
| WARN-6 | Design chosen without Greg's review | Escalated |
| WARN-7 | Missing `robots.txt` | Fixed |
| WARN-8 | No custom 404 page | Fixed — branded 404 with nav |

**Info (7) — 1 fixed, 3 dismissed, 3 escalated:**

| ID | Issue | Resolution |
|----|-------|------------|
| INFO-1 | Email placeholder unconfirmed | Escalated |
| INFO-2 | RSS excludes link roundups | Escalated |
| INFO-3 | Fragile ThemeSwitcher selector | Fixed |
| INFO-4 | No blog pagination (98 posts) | Escalated |
| INFO-5 | Missing blog post descriptions | Escalated |
| INFO-6 | `prose` classes without typography plugin | Dismissed — visual QA only |
| INFO-7 | Profile photo is "GB" placeholder | Dismissed — awaiting headshot |

---

## 4. Current State

- **Build**: PASSES — 103 pages, zero errors, zero warnings
- **Stack**: Astro 5, Tailwind CSS 4, DaisyUI 5
- **Pages**: Landing (`/`), About (`/about`), Blog index (`/blog`), Links index (`/links/`), 23 blog posts, 75 link roundups, 404, RSS feed, sitemap
- **Infrastructure**: GitHub Actions deploy workflow, CNAME for gabrewer.com, robots.txt, sitemap
- **Themes**: 14 DaisyUI themes with working switcher, localStorage persistence, no FOUC
- **Content**: All 98 posts migrated from 11ty, dynamic LatestPosts on landing page
- **SEO**: OG tags (article type for posts), Twitter cards, canonical URLs, RSS feed, sitemap
- **Not yet deployed**: Site built locally; needs push to main to trigger deployment

### Pending Items (no action needed yet)
- Lighthouse performance audit (no browser env available)
- Visual QA of prose typography across themes
- Profile photo (waiting on Greg's headshot)
- Blog post descriptions for SEO (Greg will write)

---

## 5. Escalated Items — Greg's Decisions Received

All 6 escalated items have received decisions from Greg in `escalated.md`:

| ID | Issue | Greg's Decision | Action Required |
|----|-------|-----------------|-----------------|
| **WARN-3** | Link roundup URLs contain literal "slash" (`links-10-slash-10-slash-2024`) | **Rename to `YYYY-MM-DD.md` format** | Rename all 75 files to produce `/links/2024-10-10/` style URLs |
| **WARN-6** | Design direction chosen without review | **"The design is too basic, I need more options"** | **Rebuild design exploration with new/improved options** |
| **INFO-1** | Contact email `greg@gabrewer.com` | **Confirmed correct** | No action needed |
| **INFO-2** | RSS feed excludes link roundups | **Create separate feed at `/links.xml`** | Build second RSS feed for links collection |
| **INFO-4** | Blog index shows all 98 posts | **"Blog page should not have link roundups; separate page"** | Remove link roundups from `/blog` index |
| **INFO-5** | Blog post descriptions missing | **"I will add descriptions"** | Greg will add `description:` frontmatter manually |

### Priority Actions for Next Build

1. **WARN-6 — Design overhaul** (highest priority): Greg rejected Option A as "too basic" and wants more options. New design exploration pages must be created before the landing page can be finalized. The previous design pages were deleted during cleanup.
2. **WARN-3 — Rename 75 link roundup files** to `YYYY-MM-DD.md` format for clean URLs.
3. **INFO-4 — Separate blog and links indexes**: Remove link roundups from the `/blog` page; they already have `/links/`.
4. **INFO-2 — Create `/links.xml`** RSS feed for link roundup posts.

---

*Briefing generated 2026-03-10 by Team Lead agent.*
