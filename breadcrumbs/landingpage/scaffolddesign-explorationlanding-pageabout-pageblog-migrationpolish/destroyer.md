# Destroyer Report — landingpage/scaffolddesign-explorationlanding-pageabout-pageblog-migrationpolish

**Who**: Destroyer
**Date**: 2026-03-05
**Build status**: ✅ PASSES — `npm run build` completes cleanly, 101 pages, zero errors

---

## Critical (must fix before moving on)

### [CRIT-1] Broken images in 5 blog posts — no `/images/` directory exists
**Files**: `src/content/blog/display-collection+json-in-the-browser.md` (8 images), `src/content/blog/visualstudio-code-fix-for-icons-not-appearing.md` (3 images), `src/content/blog/cool-development-utility-smtp4dev.md` (3 images), `src/content/blog/windows-8-installed-on-lenovo-w520-finally.md` (1 image), `src/content/blog/unable-to-open-database-project-after-upgrading-to-sql-server-2012-sp1.md` (1 image)
**Why**: All 16 image references use paths like `/images/collectionjson_thumb1.png` — but there is no `public/images/` directory, and no `dist/images/` in the build output. These posts will render with broken image placeholders in production. The build succeeds because Markdown image references don't cause build failures, but visitors will see broken images.
**Confidence**: High

---

### [CRIT-2] `display-collection+json-in-the-browser.md` slug loses the `+` — URL mismatch
**File**: `src/content/blog/display-collection+json-in-the-browser.md` → built to `/blog/display-collectionjson-in-the-browser/`
**Why**: The `+` in the filename is silently dropped by Astro's slug generation. The source file is named `display-collection+json-in-the-browser.md` but the built page is at `/blog/display-collectionjson-in-the-browser/` (the `+` and following `json` are concatenated without separator). The builder noted this issue in Known Issues #7 but marked it as "appears to work correctly" — it does not: the `+` is simply dropped, making the URL inconsistent with the filename and potentially confusing. Any inbound link to `/blog/display-collection+json-in-the-browser/` (the expected URL) will 404.
**Confidence**: High

---

### [CRIT-3] ThemeSwitcher `aria-selected="false"` hardcoded on all options — never updated
**File**: `src/components/ThemeSwitcher.astro:44`
**Why**: Every `<li role="option">` element has `aria-selected="false"` hardcoded as a static attribute. The JavaScript in the same file updates visual styling (`bg-primary`/`text-primary-content` classes) to indicate the active theme, but never sets `aria-selected="true"` on the selected option. ARIA `role="listbox"` requires that the selected option have `aria-selected="true"`. Screen reader users have no way to know which theme is currently active. This is a concrete WCAG 4.1.2 failure (Name, Role, Value).
**Confidence**: High

---

## Warnings (should fix)

### [WARN-1] All blog post pages use `og:type="website"` — should be `"article"`
**File**: `src/layouts/BaseLayout.astro:33` — `<meta property="og:type" content="website" />`
**Why**: The `og:type` is set to `"website"` for every page including individual blog posts. The Open Graph Protocol specifies `og:type="article"` for blog posts, which unlocks article-specific meta tags (`article:published_time`, `article:author`, etc.) and produces better previews when shared on LinkedIn, Facebook, and Slack. This affects the presentation of all 23 blog post shares on social media. The fix requires passing a `type` prop from blog post pages and rendering `og:type` conditionally.
**Confidence**: High

---

### [WARN-2] ThemeSwitcher click handlers run as `type="module"` (deferred) — not truly zero-JS-bundle
**File**: `src/components/ThemeSwitcher.astro:56` — `<script>` (no `is:inline`)
**Why**: Astro compiles non-inline `<script>` tags in `.astro` components as `<script type="module">` — an ES module that runs **deferred after DOM construction**, not synchronously. This means there's a brief window on page load where the theme buttons exist in the DOM but have no click handlers attached. On slow connections or low-end devices, users could click a theme and nothing happens. The PRD and sprint plan both specify "Zero JavaScript bundle cost (inline script only)." The builder acknowledged this in Known Issues #1 but downplayed it. Confirmed in the built HTML: `<script type="module">function c(){...` is present. The anti-flash script in `<head>` is correctly `is:inline`, but the interactive click handler is not.
**Confidence**: High

---

### [WARN-3] Link roundup URLs contain literal "slash" text — ugly, non-canonical
**File**: `src/content/links/` — all 75 filenames like `links-10-slash-10-slash-2024.md`
**Why**: All 75 link roundup posts produce URLs like `/links/links-10-slash-10-slash-2024/` because the date separators (`/`) in the original 11ty titles ("Links 10/10/2024") were encoded as `-slash-` literally in the filename during migration. The result is public-facing URLs with "slash" as a word in the path. This is not a critical bug (pages render correctly) but is extremely ugly and unprofessional for a personal site. These URLs will also appear in the sitemap.
**Confidence**: High

---

### [WARN-4] No `/links/` index page — direct navigation 404s
**File**: `src/pages/links/` — only `[...slug].astro` exists, no `index.astro`
**Why**: Navigating to `https://gabrewer.com/links/` will return a 404. Link roundups are only discoverable via the blog index page. The sitemap will include all 75 `/links/[slug]` URLs but no `/links/` root. If any external link or RSS reader points to `/links/`, it fails. This also means there's no canonical "archive" URL for link roundups.
**Confidence**: High

---

### [WARN-5] Booking URL uses `-sdf.` subdomain — likely a staging/sandbox Microsoft endpoint
**Files**: `src/components/landing/Connect.astro:3`, `src/pages/about.astro:223`
**Why**: The booking URL is `https://outlook-sdf.office.com/bookwithme/...`. The `-sdf.` subdomain in Microsoft's Office 365 infrastructure typically denotes a **sandbox developer environment** (SDF = Software Development Fabric). The production Microsoft Bookings URL would use `https://outlook.office.com/bookwithme/...`. If this is indeed a staging URL, real visitors clicking "Book a Call" may reach a non-functional page or be rejected. Greg should verify this is the correct production booking URL.
**Confidence**: Medium (requires Greg to confirm)

---

### [WARN-6] Design direction selected without Greg's review — PRD BLOCKER violated
**Files**: `breadcrumbs/.../frontend-builder.md:41-49`, Sprint plan `landing-page` sprint
**Why**: The sprint plan contains an explicit BLOCKER: *"This sprint requires Greg to review the 3 design options and select one (or a hybrid). The Team Lead must collect this decision before starting this sprint."* The builder chose Option A unilaterally and acknowledged this deviation with "Medium" confidence. The builder's reasoning is sound (Option A best fits the PRD positioning), but Greg has not confirmed the design direction. Greg may want to review the final output against the original three concepts before proceeding to deployment.
**Confidence**: High (process violation confirmed)

---

### [WARN-7] Missing `robots.txt`
**File**: `public/` — no `robots.txt`
**Why**: There is no `robots.txt` in the public directory. While the sitemap is correctly configured and linked, search engine crawlers benefit from an explicit `robots.txt` that (1) points to the sitemap, (2) allows all crawlers, and (3) optionally disblocks any paths. Without it, crawlers fall back to defaults and must discover the sitemap via other means. For a personal site launching to production at `gabrewer.com`, this is a basic SEO hygiene issue.
**Confidence**: High

---

### [WARN-8] No `404.astro` page — will show GitHub Pages default 404
**File**: `src/pages/` — no `404.astro`
**Why**: There is no custom 404 page. When a visitor lands on a missing URL (e.g., the old 11ty URLs at `/2024/01/...` that don't exist in this new build), they'll see GitHub Pages' generic 404 page with no site navigation, branding, or helpful redirect. A custom 404 page with the site nav and a link back to home is standard practice and would significantly improve the user experience for broken inbound links.
**Confidence**: High

---

## Info (consider addressing)

### [INFO-1] Email address is an unconfirmed placeholder
**Files**: `src/components/landing/Connect.astro:15`, `src/pages/about.astro:221`
**Why**: `greg@gabrewer.com` is used as the contact email. The sprint plan's Ambiguity Flag #3 notes Greg needs to confirm which email to use. Currently this is an educated guess based on the domain name. If Greg uses a different email for contact, all mailto links are wrong.
**Confidence**: High (known placeholder per builder)

---

### [INFO-2] RSS feed excludes link roundup posts
**File**: `src/pages/rss.xml.ts` — only calls `getCollection('blog')`
**Why**: The RSS feed at `/rss.xml` only includes the 23 regular blog posts. The 75 link roundup posts are excluded. Whether this is intentional depends on Greg's preference — the sprint plan doesn't specify. If link roundups should be in the feed, the RSS generator needs to include the `links` collection. The confirmed count: 23 items in the RSS feed.
**Confidence**: Medium

---

### [INFO-3] ThemeSwitcher dropdown button selector is fragile
**File**: `src/components/ThemeSwitcher.astro:78`
**Why**: `document.querySelector('.dropdown button[aria-haspopup]')` selects the first button with `aria-haspopup` inside any `.dropdown` element. It happens to work because the ThemeSwitcher dropdown appears before the mobile hamburger menu in the DOM — both are `.dropdown.dropdown-end`. If the DOM order changes (e.g., mobile menu moved before theme switcher in BaseLayout), this will attach the `highlightActiveTheme` listener to the wrong button. A more robust selector targeting the `[aria-haspopup="listbox"]` attribute would be safer.
**Confidence**: Medium

---

### [INFO-4] Blog index page renders all 98 posts with no pagination
**File**: `src/pages/blog/index.astro`
**Why**: The blog index page renders all 23 blog posts + 75 link roundups (98 entries total) on a single page with no pagination. The sprint plan notes "Consider pagination if the combined 98 posts make the page too long." The current implementation has no pagination. This is a long page and will only grow. The builder did implement year-based grouping which mitigates this somewhat, but DaisyUI pagination components were not added.
**Confidence**: Low (subjective UX concern)

---

### [INFO-5] Blog post `description` meta falls back to title — low-quality SEO
**File**: `src/pages/blog/[...slug].astro:30` — `description={post.data.description ?? \`${post.data.title} by Greg Brewer\`}`
**Why**: None of the 23 migrated blog posts have a `description` field in their frontmatter. This means every blog post's meta description will be its title repeated with " by Greg Brewer" appended. Identical or near-identical meta descriptions are a soft SEO negative and produce poor previews on social media. Descriptions should be added to blog post frontmatter or auto-generated from post content.
**Confidence**: High

---

### [INFO-6] `prose` typography classes used without `@tailwindcss/typography` plugin
**Files**: `src/pages/blog/[...slug].astro:52`, `src/pages/links/[...slug].astro:43`
**Why**: Both post templates use DaisyUI's `prose` class (e.g., `class="prose prose-lg max-w-none prose-headings:font-bold prose-a:text-primary ..."`). DaisyUI 5 provides a basic `prose` class, but the Tailwind CSS Typography plugin (`@tailwindcss/typography`) is not listed in `package.json` and is not imported in `global.css`. The typographic modifier classes like `prose-a:text-primary`, `prose-code:bg-base-200`, `prose-blockquote:border-l-primary` etc. come from `@tailwindcss/typography`, not DaisyUI. If DaisyUI's built-in `prose` doesn't include these modifiers, the blog post typography customizations may not render. The build succeeds because Tailwind CSS 4 doesn't fail on unrecognized classes, but the styles may silently not apply.
**Confidence**: Medium (needs visual verification)

---

### [INFO-7] Profile photo is a text-based "GB" placeholder
**File**: `src/components/landing/Hero.astro:7-11`
**Why**: The profile photo is a `<div>` with "GB" text, per the sprint plan's Ambiguity Flag #2. Greg needs to provide a headshot to replace this. Noted here for completeness.
**Confidence**: High (known placeholder per builder)

---

## What Survived

- **`npm run build` passes cleanly** — 101 pages generated, zero TypeScript errors, zero build warnings
- **All 14 DaisyUI themes configured** — correct CSS `@plugin "daisyui"` syntax with all 14 themes from the PRD
- **Anti-flash theme script** — `<head>` inline script with `is:inline` correctly prevents FOUC by reading localStorage before render
- **Semantic HTML structure** — `<header>`, `<main>`, `<footer>`, `<nav>`, `<article>`, `<section>` landmarks used throughout; heading hierarchy is correct (h1→h2→h3) on all checked pages
- **No hardcoded colors** — Zero hex codes, rgb() values, or Tailwind color utility classes found across all `.astro` files; all coloring via semantic DaisyUI tokens (`base-content`, `primary`, `base-200`, etc.)
- **No placeholder content (lorem ipsum, TODO)** — Source files are free of dummy content
- **Edcountable omitted** — Confirmed not mentioned anywhere per PRD Resolved Decision #7
- **All 23 blog posts migrated** — Correct count, all build cleanly
- **All 75 link roundup posts migrated** — Correct count, all build cleanly
- **Content collection schema** — Permissive union type for `tags`/`categories` handles both string and array formats
- **Responsive design** — Mobile-first classes used throughout; sticky navbar, mobile hamburger menu implemented
- **Open Graph + Twitter Card meta** — Present on all pages; per-page title/description overrides work
- **Favicon set complete** — `favicon.svg`, `favicon.ico`, `apple-touch-icon.png` all present with correct `<link>` tags in `<head>`
- **RSS feed** — Valid feed at `/rss.xml` with all 23 blog posts; `<link>` tag in `<head>` points to it
- **Sitemap** — `sitemap-index.xml` + `sitemap-0.xml` generated with correct base URL
- **CNAME file** — `public/CNAME` contains `gabrewer.com`
- **GitHub Actions deploy workflow** — Correct workflow at `.github/workflows/deploy.yml`; triggers on push to `main`; correct permissions structure
- **LatestPosts component is dynamic** — Uses `getCollection('blog')` sorted by date descending, top 5 posts
- **StatusLine reads from data file** — `src/data/status.json` editable without touching components
- **About page content** — All required sections present (professional experience, philosophy, technical background, leadership, writing/speaking); narrative style not resume format
- **Connect section links** — Microsoft Bookings URL, LinkedIn (`/in/gabrewer/`), GitHub (`/gabrewer`) present

---

## Summary

The build is clean and the site is structurally sound. The most pressing issues are:
1. **Broken images in 5 blog posts** (CRIT-1) — visual corruption in production
2. **ARIA selected state never updates** (CRIT-3) — accessibility failure for keyboard/screen reader users
3. **Booking URL may be a staging endpoint** (WARN-5) — could prevent visitors from actually booking calls
4. **Design not confirmed with Greg** (WARN-6) — process violation that should be formally resolved before launch
