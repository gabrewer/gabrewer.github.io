# Greg Brewer — Personal Landing Page

**One-liner:** A fast, living professional landing page that signals engineering credibility in the AI agentic coding space — with an integrated blog, theme switcher, and clear paths to connect.

---

## Problem & Audience

### The Person
A startup CEO, engineering leader, or conference organizer who just heard Greg's name — maybe from a talk, a blog post, or a referral. They're evaluating whether Greg is the right person to help their team navigate AI-driven development. They need to answer three questions fast:

1. Does this person actually know what they're talking about?
2. Are they doing real work right now, or just talking about it?
3. How do I get in touch?

### The Problem
Greg needs a professional home on the web that positions him as a leader in applying engineering principles to the AI agentic coding landscape. His current blog at gabrewer.com (built with 11ty) is separate from any landing presence and needs to be consolidated into a single, cohesive site.

---

## Core Features

### 1. Identity & Positioning (Must-Have)
Name, professional title, and a clear tagline that communicates Greg's unique angle: applying engineering discipline to the AI agentic coding landscape. This is the first thing visitors see. It should take less than 2 seconds to understand who Greg is and what he's about.

### 2. Current Status Line (Must-Have)
A single, updatable line near the top of the page that communicates what Greg is actively working on or thinking about right now. Examples:
- "Currently: Preparing a talk on the future of software engineering for UMich EECS 441"
- "Currently: Deep in multi-agent workflow architecture for Lessi AI"

Updated by editing a single line in the source and redeploying. Low friction, high signal. Makes the page feel alive.

### 3. What I'm Building — Lessi AI (Must-Have)
A featured section highlighting Lessi AI as the primary proof point. Brief description of what it is (AI platform for special education teachers), Greg's role (Co-Founder & CTO), and why it matters. This demonstrates that Greg is actively building in the AI space, not just advising from the sidelines.

### 4. Speaking & Training (Must-Have)
A section that highlights speaking engagements and training work. Initially features the University of Michigan EECS 441 talk. Structured so future engagements can be easily added. This is key for the audience — people looking to hire Greg to speak or train their teams need to see that he's already doing it.

### 5. Latest Blog Posts (Must-Have)
The most recent 3-5 blog post titles and dates rendered directly on the landing page, linking to the full posts. The blog is part of the same Astro site — not a separate link, but a living piece of the surface. Blog posts live under a `/blog` route within the site.

### 6. Blog (Must-Have)
Full blog migrated from the existing 11ty site at gabrewer.com into this Astro project. All existing posts preserved. Uses Astro content collections. Individual post pages with clean typography. Blog index page at `/blog`.

### 7. Connect / Contact (Must-Have)
Clear calls to action for people who want to reach out:
- Email link
- Book a call link (can be a Calendly or similar — placeholder URL initially)
- LinkedIn profile link
- GitHub profile link

Designed as "reach out if this resonates" — not a services pitch. Structured so it could evolve into an active services offering later without a redesign.

### 8. About / Experience Page (Must-Have)
A separate page (not on the landing page) that provides the receipts — 30+ years of experience, companies worked with (Learning A-Z, Strata Oncology, ABEM), technical background, engineering philosophy, leadership experience. This is the "deep dive" for people who want to vet Greg's background. Content sourced from `personal-info.md`.

### 9. Theme Switcher (Must-Have)
A DaisyUI theme switcher that lets visitors choose from a curated set of professional themes. Selection persisted to localStorage so it sticks across visits. Themes applied via the `data-theme` attribute on `<html>`. Curated set TBD — selected from DaisyUI's 35+ built-in themes.

### 10. Performance (Must-Have)
The site itself is a calling card for engineering quality. Targets:
- Lighthouse score of 100 across all categories
- Sub-second load times
- Zero unnecessary JavaScript
- Semantic HTML, accessible markup
- The medium is the message.

---

## Non-Goals

- **Not a portfolio site.** No project gallery, no case studies, no screenshots. The work speaks through the blog and the "what I'm building" section.
- **Not a resume.** The about page provides background, but this is not a CV. No timeline, no bullet-point job history.
- **Not a services page (yet).** No pricing, no packages, no "hire me" form. The contact section is "let's talk" not "buy now." This may change later.
- **No CMS.** Content is managed in source files and deployed via GitHub Pages. No headless CMS, no admin panel.
- **No analytics (initially).** Can be added later if needed. Keep the initial build clean and dependency-free.
- **No comments or interactivity.** Blog posts are static. No comment system, no reactions, no newsletter signup (yet).
- **No auto-updating status.** The current status line is manually edited. No API integrations, no GitHub activity feeds, no automated "what I'm doing" scrapers.

---

## Technical Considerations

### Stack
- **Framework:** Astro (static site generation)
- **Styling:** Tailwind CSS + DaisyUI
- **Hosting:** GitHub Pages
- **Blog:** Astro Content Collections (Markdown/MDX)
- **Theme Switching:** DaisyUI `data-theme` attribute + localStorage persistence
- **Deployment:** GitHub Actions (build Astro, deploy to Pages)

### Architecture Notes
- Single Astro project with multiple pages: landing (`/`), blog index (`/blog`), individual posts (`/blog/[slug]`), about (`/about`)
- Blog posts stored as Markdown files in `src/content/blog/`
- Current status stored in a simple data file or frontmatter that the landing page reads
- Theme switcher implemented as a small inline `<script>` (no framework needed) — reads/writes localStorage, sets `data-theme` on `<html>`
- DaisyUI themes configured via `@plugin "daisyui"` in CSS with a curated subset enabled
- GitHub Actions workflow for automatic deployment on push to `main`

### Migration Notes
- Existing 11ty blog posts at gabrewer.com need to be migrated to Astro content collections
- Frontmatter format may need adjustment (11ty → Astro)
- URL structure should be preserved where possible to avoid breaking existing links
- DNS/GitHub Pages configuration will need to point gabrewer.com to the new Astro site

### Risks & Unknowns
- Existing blog post count and frontmatter format — need to audit the 11ty source
- Book-a-call service — Greg needs to choose a provider (Calendly, Cal.com, etc.) or use a placeholder
- Theme curation — need to review DaisyUI themes and pick the right set
- Custom domain setup — may need to coordinate DNS changes

---

## Milestones

### Milestone 0: Design Exploration
Present 3 distinct layout/design options for the landing page, each as a working HTML prototype rendered in the browser. The options should share the same content but differ in layout, visual hierarchy, and personality:

- **Option A:** Minimal and focused — centered single-column layout, lots of whitespace, content reveals as you scroll. Feels like a senior engineer's personal page.
- **Option B:** Editorial / magazine-inspired — asymmetric grid, blog content given more visual weight, feels like someone who writes and thinks publicly.
- **Option C:** Dashboard-style — structured cards/panels, information-dense, feels like a builder's workbench where you can see everything at a glance.

Each option should use DaisyUI components and demonstrate the theme switcher so Greg can evaluate how themes interact with the layout. Greg selects one (or a hybrid) before moving to Milestone 1.

**Deliverable:** 3 rendered design options in the browser. Greg picks a direction.

### Milestone 1: Project Scaffold
Astro project initialized with Tailwind CSS and DaisyUI. Basic layout component with theme switcher working. GitHub Actions deployment pipeline to GitHub Pages. Site deploys and loads with a placeholder page.

**Deliverable:** Empty site with working theme switcher, deployed to GitHub Pages.

### Milestone 2: Landing Page
All landing page sections built: identity/positioning, current status, Lessi AI feature, speaking/training, latest blog posts (hardcoded initially), and connect/contact section. Responsive, accessible, fast.

**Deliverable:** Complete landing page at `/`.

### Milestone 3: About Page
Separate `/about` page with full professional background, experience, technical skills, engineering philosophy, and leadership history. Content sourced from `personal-info.md`.

**Deliverable:** Complete about page at `/about`.

### Milestone 4: Blog Migration
Existing 11ty blog posts migrated to Astro content collections. Blog index page at `/blog`. Individual post pages with clean typography. Landing page updated to dynamically pull latest posts.

**Deliverable:** Fully functional blog with all existing posts migrated.

### Milestone 5: Polish & Launch
Performance optimization (Lighthouse 100). Final theme curation. Meta tags and Open Graph setup. Favicon. Final review. DNS cutover to point gabrewer.com at the new site.

**Deliverable:** Production-ready site live at gabrewer.com.

---

## Resolved Decisions

1. **DaisyUI Themes:** Light (default), Dark, Abyss, Aqua, Caramellatte, Cyberpunk, Dim, Garden, Lemonade, Luxury, Retro, Silk, Synthwave, Valentine
2. **Book-a-call:** Microsoft Bookings — `https://outlook-sdf.office.com/bookwithme/user/9eb0e58935e84f68a9faccb3732b0077@lessi.ai?anonymous&ep=signature`
3. **Existing blog source:** Located at `/home/gabrewer/source/gabrewer.github.io` (11ty). Needs audit for post count, frontmatter format, and content types.
4. **URL structure:** Preserve existing 11ty URL structure to avoid breaking links.
5. **Custom domain:** gabrewer.com already points to GitHub Pages. Will need to update the repo that Pages serves from.
6. **Profile photo:** Yes, include a photo on the landing page.
7. **Edcountable:** Do not mention on the site for now. Lessi AI only.

---

## Open Questions

1. **Blog audit:** Need to inspect the 11ty source at `/home/gabrewer/source/gabrewer.github.io` to determine post count, frontmatter format, URL patterns, and any non-Markdown content before migration.
2. **Profile photo:** Greg needs to provide a headshot image file.
3. **Email address:** Which email should the contact link use?
