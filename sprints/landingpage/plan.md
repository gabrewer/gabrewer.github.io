# Sprint Plan — landingpage

Generated from: PRD.md
Date: 2026-03-05

---

## Sprint: scaffold

**Name**: Project Scaffold & Infrastructure

### Task: init-astro-project
- **Type**: prescriptive
- **Description**: Initialize a new Astro project in the repository root. Install Astro 5.x, Tailwind CSS 4, DaisyUI 5, and configure them. Set up the project structure: `src/pages/`, `src/layouts/`, `src/components/`, `src/content/blog/`, `src/data/`, `src/styles/`, and `public/`. Configure `astro.config.mjs` with `site: 'https://gabrewer.com'` and the Astro Tailwind integration. Configure DaisyUI as a Tailwind plugin in the CSS using `@plugin "daisyui"` syntax (Tailwind CSS 4 style). Enable the curated theme set from PRD Resolved Decision #1: Light (default), Dark, Abyss, Aqua, Caramellatte, Cyberpunk, Dim, Garden, Lemonade, Luxury, Retro, Silk, Synthwave, Valentine.
- **Acceptance Criteria**:
  - [ ] `npm run dev` starts the Astro dev server without errors
  - [ ] `npm run build` produces a static site in `dist/`
  - [ ] Tailwind CSS 4 utility classes render correctly
  - [ ] DaisyUI component classes (e.g. `btn`, `card`) render correctly
  - [ ] All 14 curated DaisyUI themes are available via `data-theme` attribute
  - [ ] Project structure includes `src/pages/`, `src/layouts/`, `src/components/`, `src/content/`, `src/styles/`, `public/`
- **Dependencies**: none
- **Assigned to**: frontend-builder

### Task: base-layout
- **Type**: prescriptive
- **Description**: Create a `BaseLayout.astro` component in `src/layouts/` that serves as the shared layout for all pages. It should include: proper `<!DOCTYPE html>`, `<html>` with `lang="en"` and `data-theme` attribute (defaulting to "light"), `<head>` with charset, viewport meta, title prop, and global CSS import, `<body>` with a `<slot />` for page content. Add a site-wide navigation bar (DaisyUI `navbar` component) with links to Home (`/`), Blog (`/blog`), and About (`/about`). Add a minimal footer with copyright. Import the global stylesheet.
- **Acceptance Criteria**:
  - [ ] All pages using BaseLayout render with consistent nav and footer
  - [ ] Navigation links to `/`, `/blog`, `/about` are present and functional
  - [ ] `<html>` tag has `data-theme` attribute
  - [ ] Page title is configurable via prop
  - [ ] Semantic HTML structure (`<header>`, `<main>`, `<footer>`)
- **Dependencies**: scaffold/init-astro-project
- **Assigned to**: frontend-builder

### Task: theme-switcher
- **Type**: prescriptive
- **Description**: Implement a theme switcher component that lets visitors choose from the 14 curated DaisyUI themes. The switcher should be placed in the navbar. Implementation: a DaisyUI dropdown or select menu listing all theme names. On selection, set `document.documentElement.setAttribute('data-theme', theme)` and persist to `localStorage`. On page load, an inline `<script>` in `BaseLayout.astro` (before body content to prevent flash) reads `localStorage` and sets `data-theme`. No framework JS required — use vanilla inline script only.
- **Acceptance Criteria**:
  - [ ] Theme switcher is visible in the navbar on all pages
  - [ ] Clicking a theme name immediately changes the page theme
  - [ ] Selected theme persists across page reloads (localStorage)
  - [ ] No flash of wrong theme on page load (script runs before render)
  - [ ] All 14 themes are listed and functional
  - [ ] Zero JavaScript bundle cost (inline script only)
- **Dependencies**: scaffold/base-layout
- **Assigned to**: frontend-builder

### Task: placeholder-pages
- **Type**: prescriptive
- **Description**: Create placeholder pages so the site is navigable and buildable: `src/pages/index.astro` (landing page with "Coming soon" content), `src/pages/blog/index.astro` (blog index placeholder), `src/pages/about.astro` (about page placeholder). Each page should use `BaseLayout` and have a heading indicating the page name. This ensures the site builds and all nav links resolve.
- **Acceptance Criteria**:
  - [ ] `/` renders with BaseLayout and placeholder content
  - [ ] `/blog` renders with BaseLayout and placeholder content
  - [ ] `/about` renders with BaseLayout and placeholder content
  - [ ] All navigation links work without 404s
  - [ ] `npm run build` succeeds with all three pages
- **Dependencies**: scaffold/theme-switcher
- **Assigned to**: frontend-builder

### Task: github-actions-deploy
- **Type**: prescriptive
- **Description**: Create a GitHub Actions workflow at `.github/workflows/deploy.yml` that builds the Astro site and deploys to GitHub Pages on push to `main`. Use the official Astro GitHub Pages deployment pattern: `actions/checkout`, `actions/setup-node`, `npm ci`, `npm run build`, and `actions/deploy-pages`. Configure `astro.config.mjs` with the correct output settings for GitHub Pages. Add a CNAME file in `public/` with `gabrewer.com`.
- **Acceptance Criteria**:
  - [ ] `.github/workflows/deploy.yml` exists with correct workflow
  - [ ] Workflow triggers on push to `main`
  - [ ] Workflow builds the Astro site and deploys to GitHub Pages
  - [ ] `public/CNAME` contains `gabrewer.com`
  - [ ] `astro.config.mjs` configured for GitHub Pages output
- **Dependencies**: scaffold/placeholder-pages
- **Assigned to**: frontend-builder

---

## Sprint: design-exploration

**Name**: Design Exploration — 3 Layout Options

### Task: design-option-a
- **Type**: goal-oriented
- **Description**: Create Design Option A — "Minimal & Focused". A centered single-column layout with generous whitespace. Content reveals as you scroll. Feels like a senior engineer's personal page. Build this as a working Astro page at `src/pages/designs/option-a.astro` using real content from the PRD and `personal-info.md`. Must include all landing page sections: identity/positioning with profile photo placeholder, current status line, Lessi AI feature section, speaking/training section, latest blog posts (hardcoded 3-5 items), and connect/contact section. Use DaisyUI components and demonstrate the theme switcher integration.
- **Acceptance Criteria**:
  - [ ] Page renders at `/designs/option-a`
  - [ ] Single-column centered layout with generous whitespace
  - [ ] All 7 landing page content sections present (identity, status, Lessi AI, speaking, blog posts, connect)
  - [ ] Profile photo placeholder (image element with placeholder)
  - [ ] Theme switcher works and themes look coherent with this layout
  - [ ] Responsive — works on mobile, tablet, desktop
  - [ ] Uses DaisyUI components throughout
  - [ ] Real content from PRD and personal-info.md (not lorem ipsum)
- **Dependencies**: scaffold/placeholder-pages
- **Assigned to**: frontend-builder

### Task: design-option-b
- **Type**: goal-oriented
- **Description**: Create Design Option B — "Editorial / Magazine-Inspired". An asymmetric grid layout where blog content is given more visual weight. Feels like someone who writes and thinks publicly. Build at `src/pages/designs/option-b.astro` with the same real content as Option A. Different layout, visual hierarchy, and personality. Blog posts section should be more prominent. Use DaisyUI components.
- **Acceptance Criteria**:
  - [ ] Page renders at `/designs/option-b`
  - [ ] Asymmetric grid layout with blog content visually prominent
  - [ ] All 7 landing page content sections present
  - [ ] Profile photo placeholder
  - [ ] Theme switcher works and themes look coherent
  - [ ] Responsive
  - [ ] Visually distinct from Option A
  - [ ] Real content from PRD and personal-info.md
- **Dependencies**: scaffold/placeholder-pages
- **Assigned to**: frontend-builder

### Task: design-option-c
- **Type**: goal-oriented
- **Description**: Create Design Option C — "Dashboard-Style". Structured cards/panels in a grid, information-dense layout. Feels like a builder's workbench where you can see everything at a glance. Build at `src/pages/designs/option-c.astro` with the same real content. Use DaisyUI card components prominently. Different visual feel from A and B.
- **Acceptance Criteria**:
  - [ ] Page renders at `/designs/option-c`
  - [ ] Card/panel-based grid layout, information-dense
  - [ ] All 7 landing page content sections present
  - [ ] Profile photo placeholder
  - [ ] Theme switcher works and themes look coherent
  - [ ] Responsive
  - [ ] Visually distinct from Options A and B
  - [ ] Real content from PRD and personal-info.md
- **Dependencies**: scaffold/placeholder-pages
- **Assigned to**: frontend-builder

### Task: design-index
- **Type**: prescriptive
- **Description**: Create a design comparison page at `src/pages/designs/index.astro` that links to all three options with brief descriptions. This is a convenience page for Greg to review all three options. Include the design descriptions from the PRD (Minimal, Editorial, Dashboard).
- **Acceptance Criteria**:
  - [ ] Page renders at `/designs/`
  - [ ] Links to all three design options with descriptions
  - [ ] Clear labeling: Option A, B, C with design philosophy
- **Dependencies**: design-exploration/design-option-a, design-exploration/design-option-b, design-exploration/design-option-c
- **Assigned to**: frontend-builder

---

## Sprint: landing-page

**Name**: Landing Page Build

> **BLOCKER**: This sprint requires Greg to review the 3 design options and select one (or a hybrid). The Team Lead must collect this decision before starting this sprint.

### Task: build-landing-page
- **Type**: goal-oriented
- **Description**: Build the production landing page at `src/pages/index.astro` based on Greg's selected design direction. Extract reusable components for each section into `src/components/landing/`: `Hero.astro` (identity, tagline, profile photo placeholder), `StatusLine.astro` (current status — reads from a data file at `src/data/status.json`), `LessiFeature.astro` (Lessi AI section), `Speaking.astro` (speaking/training section), `LatestPosts.astro` (hardcoded for now, will be dynamic in blog-migration sprint), `Connect.astro` (contact links). Content should come from `personal-info.md` data. The current status should be editable by changing a single line in `src/data/status.json`.
- **Acceptance Criteria**:
  - [ ] Landing page renders at `/` with full content
  - [ ] Each section is a separate component in `src/components/landing/`
  - [ ] Identity section: name, title, tagline, profile photo placeholder
  - [ ] Status line reads from `src/data/status.json` and displays current status
  - [ ] Lessi AI section: description, role, why it matters
  - [ ] Speaking section: UMich EECS 441 featured, structured for adding more
  - [ ] Latest posts section: 3-5 hardcoded post titles/dates with links
  - [ ] Connect section: email link (placeholder), booking link (Microsoft Bookings URL from PRD), LinkedIn, GitHub
  - [ ] Fully responsive
  - [ ] Semantic, accessible HTML
  - [ ] Passes axe accessibility audit with no critical issues
- **Dependencies**: design-exploration/design-index
- **Assigned to**: frontend-builder

### Task: cleanup-design-pages
- **Type**: prescriptive
- **Description**: Remove the design exploration pages (`src/pages/designs/`) now that the design direction has been selected and the landing page is built. These were temporary artifacts for the design review process.
- **Acceptance Criteria**:
  - [ ] `src/pages/designs/` directory is deleted
  - [ ] No broken links in the site (designs pages were not linked from nav)
  - [ ] `npm run build` succeeds
- **Dependencies**: landing-page/build-landing-page
- **Assigned to**: frontend-builder

---

## Sprint: about-page

**Name**: About Page

### Task: build-about-page
- **Type**: goal-oriented
- **Description**: Build the About page at `src/pages/about.astro` using content sourced from `personal-info.md`. This is the "deep dive" page for vetting Greg's background. Include sections for: professional experience (30+ years, Fractional CTO work, companies: Learning A-Z, Strata Oncology, ABEM), engineering philosophy, technical background (core tech, architecture, AI systems), current technical focus, leadership experience, and writing/speaking. Do NOT mention Edcountable (per PRD Resolved Decision #7). Use the same visual language as the landing page. Match the selected design direction's typography and spacing. Note: this is NOT a resume or CV — no timeline, no bullet-point job history. It should read as a narrative/professional profile.
- **Acceptance Criteria**:
  - [ ] About page renders at `/about` with full content
  - [ ] Professional experience section with companies mentioned
  - [ ] Engineering philosophy section
  - [ ] Technical background section (core tech, architecture, AI)
  - [ ] Leadership section
  - [ ] Writing & speaking section
  - [ ] No mention of Edcountable
  - [ ] Consistent visual style with landing page
  - [ ] Responsive and accessible
  - [ ] Navigation "About" link works
- **Dependencies**: landing-page/build-landing-page
- **Assigned to**: frontend-builder

---

## Sprint: blog-migration

**Name**: Blog Migration from 11ty

### Task: setup-content-collection
- **Type**: prescriptive
- **Description**: Set up the Astro content collection for blog posts. Create `src/content/config.ts` with a `blog` collection schema that handles the frontmatter from the existing 11ty posts: `title` (string, required), `date` (date, required), `author` (string, optional), `categories` (array of strings, optional), `tags` (union of string or array of strings, optional — 11ty posts use both formats), `description` (string, optional), `comments` (boolean, optional). Also create a `links` collection for the useful_links roundup posts with the same schema. Ensure the schema is permissive enough to handle both post types without validation errors.
- **Acceptance Criteria**:
  - [ ] `src/content/config.ts` defines `blog` and `links` collections
  - [ ] Schema handles all frontmatter fields from both post types
  - [ ] Schema handles `tags` as either string or array (11ty inconsistency)
  - [ ] `npm run build` succeeds with the collection defined (even if empty)
- **Dependencies**: about-page/build-about-page
- **Assigned to**: frontend-builder

### Task: migrate-blog-posts
- **Type**: prescriptive
- **Description**: Migrate all 23 blog posts from `/home/gabrewer/source/gabrewer.github.io/posts/` into `src/content/blog/`. The partial Astro migration at `/home/gabrewer/source/gabrewer.github.io/src/content/blog/` already has the 23 posts with slightly adjusted frontmatter (tags as arrays). Use those pre-migrated files as the starting point. Verify each file's frontmatter conforms to the content collection schema. Fix any issues (e.g., ensure `tags` is always an array, ensure `date` parses correctly, strip the date prefix from filenames if present in the source to produce clean slugs). The slug format should match the 11ty URL pattern where possible. The 11ty permalink was `/YYYY/MM/slug/`.
- **Acceptance Criteria**:
  - [ ] All 23 blog posts exist in `src/content/blog/`
  - [ ] Each post has valid frontmatter that passes schema validation
  - [ ] `npm run build` succeeds with all posts loaded
  - [ ] No duplicate posts
  - [ ] Post content (body markdown) is preserved exactly
- **Dependencies**: blog-migration/setup-content-collection
- **Assigned to**: frontend-builder

### Task: migrate-useful-links
- **Type**: prescriptive
- **Description**: Migrate all 75 useful_links roundup posts from `/home/gabrewer/source/gabrewer.github.io/useful_links/` into `src/content/links/`. Adjust frontmatter to conform to the `links` collection schema. The frontmatter has: `title` (with quotes), `date`, `comments`, `categories`, `tags`. Ensure `tags` is always an array format. Strip date prefix from filenames to produce clean slugs. These link roundup posts should be treated as a separate content collection from the main blog posts.
- **Acceptance Criteria**:
  - [ ] All 75 useful_links posts exist in `src/content/links/`
  - [ ] Each post has valid frontmatter that passes schema validation
  - [ ] `npm run build` succeeds with all link posts loaded
  - [ ] Post content preserved exactly
- **Dependencies**: blog-migration/setup-content-collection
- **Assigned to**: frontend-builder

### Task: blog-post-page
- **Type**: goal-oriented
- **Description**: Create the individual blog post page template at `src/pages/blog/[...slug].astro` using Astro's dynamic routing with `getStaticPaths()`. The page should render the full post content with clean typography (DaisyUI `prose` class), display the post title, date, categories/tags, and provide navigation back to the blog index. Also create a similar template for link roundup posts. Consider the 11ty URL structure (`/YYYY/MM/slug/`) — implement redirects or match the URL pattern to preserve existing links. Use `getCollection('blog')` and `getCollection('links')` to generate all pages.
- **Acceptance Criteria**:
  - [ ] Individual blog posts render at their URLs
  - [ ] Clean typography using DaisyUI prose/Tailwind typography
  - [ ] Post title, date, and categories displayed
  - [ ] Link back to blog index
  - [ ] All 23 blog posts render without errors
  - [ ] All 75 link roundup posts render without errors
  - [ ] URL structure preserves or redirects from old 11ty URLs
- **Dependencies**: blog-migration/migrate-blog-posts, blog-migration/migrate-useful-links
- **Assigned to**: frontend-builder

### Task: blog-index-page
- **Type**: goal-oriented
- **Description**: Build the blog index page at `src/pages/blog/index.astro`. Display all blog posts and link roundups in reverse chronological order. Show post title, date, and optionally categories. Posts link to their individual pages. Consider pagination if the combined 98 posts make the page too long — DaisyUI has pagination components. The page should clearly distinguish between regular blog posts and link roundup posts (e.g., with a label or visual indicator).
- **Acceptance Criteria**:
  - [ ] Blog index renders at `/blog`
  - [ ] All posts listed in reverse chronological order
  - [ ] Each entry shows title, date, and links to full post
  - [ ] Visual distinction between blog posts and link roundups
  - [ ] Responsive layout
  - [ ] Pagination if needed for 98+ posts
- **Dependencies**: blog-migration/blog-post-page
- **Assigned to**: frontend-builder

### Task: dynamic-latest-posts
- **Type**: prescriptive
- **Description**: Update the `LatestPosts.astro` landing page component to dynamically pull the latest 3-5 blog posts from the content collection instead of using hardcoded data. Use `getCollection('blog')`, sort by date descending, take the first 5, and render titles with dates and links to the full posts. Only show regular blog posts (not link roundups) on the landing page.
- **Acceptance Criteria**:
  - [ ] Landing page "Latest Posts" section shows real blog posts from the collection
  - [ ] Posts are sorted by date, most recent first
  - [ ] Shows 3-5 posts with title, date, and link
  - [ ] Only blog posts shown (not link roundups)
  - [ ] Links navigate to the correct individual post pages
- **Dependencies**: blog-migration/blog-index-page
- **Assigned to**: frontend-builder

---

## Sprint: polish

**Name**: Polish & Launch Readiness

### Task: meta-and-seo
- **Type**: prescriptive
- **Description**: Add comprehensive meta tags and Open Graph setup to `BaseLayout.astro`. Include: `<meta name="description">` (configurable per page via prop), Open Graph tags (`og:title`, `og:description`, `og:type`, `og:url`, `og:image`), Twitter card meta tags, canonical URL, and RSS feed link tag. Create a default OG image placeholder in `public/og-image.png` (can be a simple branded image). Add `<link rel="sitemap">` pointing to the sitemap. Ensure each page can override the default description and title.
- **Acceptance Criteria**:
  - [ ] All pages have `<meta name="description">`
  - [ ] Open Graph tags present on all pages
  - [ ] Twitter card meta tags present
  - [ ] Canonical URLs set correctly
  - [ ] OG image placeholder exists
  - [ ] RSS feed link tag in `<head>`
  - [ ] Per-page title and description overrides work
- **Dependencies**: blog-migration/dynamic-latest-posts
- **Assigned to**: frontend-builder

### Task: favicon
- **Type**: prescriptive
- **Description**: Add a favicon to the site. Create a simple favicon set in `public/`: `favicon.ico`, `favicon.svg` (if possible), `apple-touch-icon.png`. Add the appropriate `<link>` tags in `BaseLayout.astro`. If no custom favicon asset is available, generate a simple text-based favicon with Greg's initials "GB".
- **Acceptance Criteria**:
  - [ ] Favicon displays in browser tab
  - [ ] `favicon.ico` exists in `public/`
  - [ ] Apple touch icon exists
  - [ ] Proper `<link>` tags in `<head>`
- **Dependencies**: blog-migration/dynamic-latest-posts
- **Assigned to**: frontend-builder

### Task: rss-feed
- **Type**: prescriptive
- **Description**: Add an RSS feed for the blog using the `@astrojs/rss` package. Create `src/pages/rss.xml.ts` that generates an RSS feed from the blog content collection. Include post title, date, description (or excerpt), and link. Configure the feed with site title "Greg Brewer", site description, and site URL.
- **Acceptance Criteria**:
  - [ ] RSS feed available at `/rss.xml`
  - [ ] Feed includes all blog posts with correct titles, dates, and links
  - [ ] Feed validates as valid RSS 2.0
  - [ ] `<link>` tag in `<head>` points to the feed
- **Dependencies**: blog-migration/dynamic-latest-posts
- **Assigned to**: frontend-builder

### Task: performance-audit
- **Type**: goal-oriented
- **Description**: Audit and optimize the site for performance. Target Lighthouse scores of 100 across all categories (Performance, Accessibility, Best Practices, SEO). Ensure sub-second load times. Check for: unnecessary JavaScript, render-blocking resources, proper image optimization, semantic HTML, ARIA attributes where needed, color contrast across all themes, proper heading hierarchy, alt text on images. Fix any issues found. Run Lighthouse on the landing page, blog index, a blog post page, and the about page.
- **Acceptance Criteria**:
  - [ ] Lighthouse Performance score >= 95 on all audited pages
  - [ ] Lighthouse Accessibility score >= 95 on all audited pages
  - [ ] Lighthouse Best Practices score >= 95 on all audited pages
  - [ ] Lighthouse SEO score >= 95 on all audited pages
  - [ ] No critical accessibility issues (axe audit)
  - [ ] Zero unnecessary JavaScript in production build
  - [ ] Semantic HTML throughout (proper heading hierarchy, landmarks)
- **Dependencies**: polish/meta-and-seo, polish/favicon, polish/rss-feed
- **Assigned to**: frontend-builder

### Task: final-review
- **Type**: goal-oriented
- **Description**: Final review of the complete site. Verify: all pages render correctly, all links work (no 404s), theme switcher works on all pages, responsive design on mobile/tablet/desktop, blog migration is complete (all 23 posts + 75 links), content accuracy against PRD and personal-info.md, connect section has correct links (Microsoft Bookings URL, LinkedIn, GitHub). Build the production site and verify the output.
- **Acceptance Criteria**:
  - [ ] All pages render without errors
  - [ ] No broken links (internal or external where testable)
  - [ ] Theme switcher functional on every page
  - [ ] Mobile responsive on all pages
  - [ ] All 23 blog posts accessible
  - [ ] All 75 link roundup posts accessible
  - [ ] Connect section links are correct per PRD
  - [ ] `npm run build` produces complete site
  - [ ] No build warnings or errors
- **Dependencies**: polish/performance-audit
- **Assigned to**: frontend-builder

---

## Sprint: design-refinement

**Name**: Landing Page Design Refinement

This sprint refines the Option A (Minimal & Focused) landing page design based on Greg's feedback. The page structure stays the same but the visual treatment changes significantly.

### Task: hero-rework
- **Type**: prescriptive
- **Description**: Rework the Hero component to lead with the positioning statement as the bold headline, not Greg's name. The new hierarchy:
  1. **Positioning statement** (large, bold, accent-colored): "Exploring ways to apply engineering principles to the AI coding landscape."
  2. **Name and title** (secondary, smaller): "Greg Brewer — Founder, CTO, AI Engineer"
  3. **Tagline** (grounding): "I build systems that help people make better decisions."
  Remove the profile photo/avatar from the Hero component — it moves to the Connect section.
- **Acceptance Criteria**:
  - [ ] Positioning statement is the visual headline, rendered large and bold
  - [ ] Positioning statement uses `text-primary` or `text-accent` to pop against the base background
  - [ ] Name/title is clearly secondary in visual weight
  - [ ] Tagline present but understated
  - [ ] No profile photo or avatar in the hero section
  - [ ] `npm run build` succeeds
- **Dependencies**: none
- **Assigned to**: frontend-builder

### Task: accent-color-pops
- **Type**: prescriptive
- **Description**: Add strategic accent color throughout the page to create visual anchors. Currently everything is muted and same-temperature. Apply color to:
  - The StatusLine pulse dot: use `bg-accent` or `bg-primary`
  - Speaking section: event titles or dates get `text-primary` or `text-accent`
  - Connect section CTA buttons: use `btn-primary` and `btn-accent` instead of neutral/ghost
  - Any links or interactive elements should use `text-primary` with hover states
  Do NOT add color everywhere — be strategic. The color should guide the eye to key moments.
- **Acceptance Criteria**:
  - [ ] StatusLine dot uses a semantic accent/primary color
  - [ ] Speaking section has at least one accent-colored element per engagement
  - [ ] Connect buttons use `btn-primary` or `btn-accent`
  - [ ] Links use `text-primary` with visible hover states
  - [ ] Page still feels clean, not noisy — color is strategic, not decorative
  - [ ] All colors use DaisyUI semantic classes (no hardcoded colors)
  - [ ] `npm run build` succeeds
- **Dependencies**: hero-rework
- **Assigned to**: frontend-builder

### Task: lessi-featured-section
- **Type**: prescriptive
- **Description**: Restyle the LessiFeature component to break out visually from the rest of the page. Give it a colored background section using `bg-primary text-primary-content` (or `bg-secondary text-secondary-content` — builder should test both and pick whichever looks better across themes). This section should feel like the visual peak of the page — the thing your eye is drawn to. Consider:
  - Making it wider than the normal content column (break out of `max-w-2xl` to `max-w-4xl` or full-width with padded content)
  - Adding slightly more padding/breathing room
  - Using `rounded-box` or a subtle card treatment
  Keep the content the same, just elevate the visual treatment.
- **Acceptance Criteria**:
  - [ ] LessiFeature section has a colored background that contrasts with the rest of the page
  - [ ] Text within the section is readable (uses matching `-content` color class)
  - [ ] Section visually breaks out from the normal column width
  - [ ] Looks good across at least 3 different DaisyUI themes (light, dark, one other)
  - [ ] `npm run build` succeeds
- **Dependencies**: hero-rework
- **Assigned to**: frontend-builder

### Task: photo-in-connect
- **Type**: prescriptive
- **Description**: Move the profile photo/avatar to the Connect section. Place it above or alongside the contact CTAs. The photo humanizes the "reach out" moment — Greg's face appears right as the visitor is deciding whether to make contact. Keep using the "GB" initials placeholder for now (real photo will be added later). Style it as a larger avatar than the original hero version — `w-24 h-24` or similar.
- **Acceptance Criteria**:
  - [ ] Profile avatar/placeholder appears in the Connect section
  - [ ] Avatar is visually prominent (larger than the original hero version)
  - [ ] Positioned naturally relative to the contact CTAs
  - [ ] No avatar/photo remains in the Hero section
  - [ ] `npm run build` succeeds
- **Dependencies**: hero-rework, accent-color-pops
- **Assigned to**: frontend-builder

---

## Ambiguity Flags

The following items from the PRD are ambiguous or unresolved and should NOT be guessed at:

1. **Design selection**: Sprint `landing-page` is blocked until Greg reviews the 3 design options and picks a direction. The Team Lead must collect this decision.
2. **Profile photo**: PRD says "include a photo" but Open Question #2 notes Greg needs to provide a headshot image file. Use a placeholder until the image is provided.
3. **Email address**: Open Question #3 — which email for the contact link? Use a placeholder `mailto:` until Greg decides.
4. **Useful links migration scope**: The PRD mentions "blog migration" but doesn't explicitly address the 75 useful_links roundup posts. This plan includes them as a separate collection since they are existing content at gabrewer.com. If Greg wants to exclude them, the `migrate-useful-links` task can be dropped.
5. **URL preservation strategy**: The 11ty permalink pattern is `/YYYY/MM/slug/`. Astro's default would be `/blog/slug/`. The plan flags this for the builder to handle (redirects or matching URLs), but the exact approach should be confirmed with Greg.
