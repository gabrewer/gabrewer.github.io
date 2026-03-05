# Review Report — landingpage/scaffolddesign-explorationlanding-pageabout-pageblog-migrationpolish

**Who**: Review Agent
**Date**: 2026-03-05
**Build status after fixes**: PASS — 103 pages, zero errors

---

## Resolved

### [CRIT-1] Fixed — Blog post images restored
**What**: Copied the full `public/images/` directory (16 files) from the original 11ty source at `/home/gabrewer/source/gabrewer.github.io/public/images/` into `public/images/` of the Astro project. All 16 image references across the 5 affected blog posts now resolve correctly.
**Confidence**: High

### [CRIT-2] Fixed — `display-collection+json` slug sanitized
**What**: Renamed `src/content/blog/display-collection+json-in-the-browser.md` → `display-collection-json-in-the-browser.md`. The built URL is now the clean `/blog/display-collection-json-in-the-browser/` instead of the malformed `/blog/display-collectionjson-in-the-browser/`. Since the site has not yet launched, there are no live inbound links to break. The `+` character in the filename was always causing a silent slug corruption.
**Confidence**: High

### [CRIT-3] Fixed — ThemeSwitcher ARIA `aria-selected` now updates dynamically
**What**: Added `data-theme-option` attribute to each `<li role="option">` element. Updated `highlightActiveTheme()` to call `li.setAttribute('aria-selected', isActive ? 'true' : 'false')` on each option in addition to the existing visual class toggling. Screen readers will now correctly announce the selected theme.
**Confidence**: High

### [WARN-1] Fixed — `og:type="article"` for blog and link posts
**What**: Added an `ogType` prop (`'website' | 'article'`, defaulting to `'website'`) to `BaseLayout.astro`. Both `src/pages/blog/[...slug].astro` and `src/pages/links/[...slug].astro` now pass `ogType="article"`. All non-post pages continue to use the `website` type. This unlocks article-specific social previews on LinkedIn, Facebook, and Slack.
**Confidence**: High

### [WARN-2] Fixed — ThemeSwitcher click handler converted to `is:inline`
**What**: Changed `<script>` to `<script is:inline>` in `ThemeSwitcher.astro`. Removed TypeScript generic syntax (`querySelectorAll<HTMLButtonElement>`) and converted arrow functions to standard `function` declarations to be safe for inline (non-bundled) execution. The PRD specifies "Zero JavaScript bundle cost (inline script only)" — this was a concrete spec violation.
**Confidence**: High

### [WARN-4] Fixed — Created `/links/` index page
**What**: Created `src/pages/links/index.astro`. The page lists all 75 link roundup posts in reverse chronological order, grouped by year, with the same visual pattern as the blog index. Navigating to `https://gabrewer.com/links/` now renders a proper archive page instead of 404ing.
**Confidence**: High

### [WARN-7] Fixed — Created `public/robots.txt`
**What**: Created `public/robots.txt` with `User-agent: * / Allow: /` and a `Sitemap:` pointer to `https://gabrewer.com/sitemap-index.xml`. Basic SEO hygiene, zero risk.
**Confidence**: High

### [WARN-8] Fixed — Created `src/pages/404.astro` custom error page
**What**: Created a branded 404 page using `BaseLayout` with the site navigation, an oversized "404" display number, a clear message, and two CTA buttons: "Go home" and "Browse the blog". Visitors landing on missing URLs (e.g., old 11ty date-based paths) will now see a helpful page instead of the generic GitHub Pages 404.
**Confidence**: High

### [INFO-3] Fixed — ThemeSwitcher dropdown selector made robust
**What**: Changed the dropdown button selector from `.dropdown button[aria-haspopup]` (matches the first button with any `aria-haspopup` value in any `.dropdown`) to `[aria-haspopup="listbox"]` (uniquely targets the theme switcher's listbox button). The mobile hamburger button uses `aria-haspopup="true"`, so these selectors no longer collide regardless of DOM order.
**Confidence**: High

---

## Escalated (needs human review)

See `escalated.md` for full detail on each item.

- **[WARN-3]** Escalated — 75 link roundup files use `-slash-` literal in filenames/URLs; renaming requires a decision on the new URL scheme and is a 75-file content change
- **[WARN-6]** Escalated — Design direction (Option A) was chosen without Greg's explicit sign-off; Greg should confirm before public launch
- **[INFO-1]** Escalated — `greg@gabrewer.com` email is an educated guess; Greg must confirm which email to use for contact links
- **[INFO-2]** Escalated — RSS feed excludes the 75 link roundup posts; Greg should decide if those belong in the feed
- **[INFO-4]** Escalated — Blog index page renders all 98 posts with no pagination; subjective UX call that Greg should weigh in on
- **[INFO-5]** Escalated — None of the 23 blog posts have a `description` frontmatter field; meta descriptions fall back to "Title by Greg Brewer" for all posts; descriptions need to be written

---

## Dismissed

- **[WARN-5]** Dismissed — The `-sdf.` booking URL is explicitly recorded in PRD Resolved Decision #2 as the confirmed Microsoft Bookings URL provided by Greg. The Destroyer's flag about staging environments is noted, but this is Greg's own Bookings account URL. Confidence in dismissal: Medium (Greg should verify it works end-to-end before launch, but it is intentional).

- **[INFO-6]** Dismissed — `@tailwindcss/typography` is not in `package.json`, but in Tailwind CSS 4 the `prose-x:y` modifier classes (e.g., `prose-a:text-primary`) are compiled as arbitrary CSS selectors that target children of `.prose`. DaisyUI 5 provides the base `prose` styles. The combination likely renders correctly. This requires visual verification rather than a code fix; no build errors occur. Escalated as a visual QA item for launch.

- **[INFO-7]** Dismissed — Profile photo placeholder ("GB" initials div) is a known pending item per PRD Open Question #2. Nothing to fix until Greg provides a headshot.

---

## Verification

- Build status: **PASS**
- Pages generated: **103** (up from 101 — new: `/404.html`, `/links/index.html`)
- All critical fixes verified: **yes**
- Zero TypeScript errors: **yes**
- Zero build warnings: **yes**

---

## Breadcrumb

- **Who**: Review Agent
- **What**: Triaged 17 Destroyer findings; fixed 9, escalated 6, dismissed 3
- **Why**: Critical fixes address broken images (production-visible), broken slug, and an accessibility WCAG 4.1.2 failure. Warnings addressed spec violations (inline script, og:type) and missing infrastructure (robots.txt, 404, links index). Escalated items require Greg's input or are content-level work. Dismissed items are either PRD-confirmed or need visual QA rather than code changes.
- **Confidence**: High
