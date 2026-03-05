# Escalated Items — landingpage/scaffolddesign-explorationlanding-pageabout-pageblog-migrationpolish

**Who**: Review Agent
**Date**: 2026-03-05

These items require human input or Greg's decision before they can be resolved. None block the build. None have been touched by automated fixes.

---

## [WARN-3] Link roundup URLs contain literal "slash" — needs URL strategy decision

**Severity**: Warning
**Affected files**: All 75 files in `src/content/links/` — filenames like `links-10-slash-10-slash-2024.md`
**Generated URLs**: `/links/links-10-slash-10-slash-2024/` (the word "slash" appears in every URL)

**Why escalated**: Fixing this requires:
1. Deciding on a new filename/slug pattern (e.g., `links-2024-10-10.md` for ISO date format, or `links-oct-10-2024.md`)
2. Renaming all 75 files
3. Deciding if the old `/links/links-10-slash-10-slash-2024/` URLs need redirects (they were never live on the new site, so there's nothing to redirect from — but the old 11ty URLs used a different pattern anyway)

**Decision needed from Greg**: Should link roundup URLs use ISO date format (`/links/links-2024-10-10/`), a different format, or is this acceptable as-is? The current slug is technically functional but unprofessional.

**Recommendation**: Rename files to `YYYY-MM-DD.md` format (e.g., `2024-10-10.md`) to produce clean URLs like `/links/2024-10-10/`. This is a mechanical rename that the builder can execute once Greg confirms the format.

---

## [WARN-6] Design direction selected without Greg's explicit confirmation

**Severity**: Warning — process violation
**Reference**: Sprint plan landing-page BLOCKER; `breadcrumbs/.../frontend-builder.md:41-49`

**Why escalated**: The sprint plan contains an explicit blocking requirement: *"This sprint requires Greg to review the 3 design options and select one (or a hybrid). The Team Lead must collect this decision before starting this sprint."* The builder chose Option A unilaterally and noted this deviation with medium confidence.

**Current state**: The site is built on Option A — "Minimal & Focused" (centered single-column, generous whitespace). The design exploration pages at `/designs/option-a`, `/designs/option-b`, `/designs/option-c` have been removed per the cleanup task.

**Decision needed from Greg**: Review the current landing page at `/` and confirm that Option A is the right direction, or request changes. If Greg wants to see the other options, the design exploration files would need to be recreated from the builder's artifacts.

**Recommendation**: Have Greg review the current live site before DNS cutover and confirm the design direction is correct.

---

## [INFO-1] Contact email address is an educated guess

**Severity**: Info — content placeholder
**Affected files**: `src/components/landing/Connect.astro:15`, `src/pages/about.astro:221`
**Current value**: `greg@gabrewer.com`

**Why escalated**: The sprint plan Ambiguity Flag #3 explicitly notes "which email for the contact link?" as an open question. `greg@gabrewer.com` is a reasonable inference from the domain, but Greg may use a different address (e.g., a Lessi AI address, a Gmail, etc.) for public contact. If this is wrong, all mailto links on the site are incorrect.

**Decision needed from Greg**: Confirm the email address to use for the contact link on the landing page and about page.

---

## [INFO-2] RSS feed excludes the 75 link roundup posts

**Severity**: Info — product decision
**Affected file**: `src/pages/rss.xml.ts` — only calls `getCollection('blog')`
**Current state**: The RSS feed at `/rss.xml` contains 23 regular blog posts; the 75 link roundups are not included.

**Why escalated**: The sprint plan doesn't specify whether link roundups should be in the RSS feed. Link roundups are a distinct content type (curated links, not original writing). Some readers would want them in the feed; others wouldn't. This is a product preference question.

**Decision needed from Greg**: Should link roundups appear in the RSS feed?
- **Yes** → update `src/pages/rss.xml.ts` to include `getCollection('links')` merged and sorted with blog posts
- **No** → current behavior is correct
- **Separate feed** → create a second feed at `/links.xml` for link roundups only

---

## [INFO-4] Blog index has no pagination — 98 posts on a single page

**Severity**: Info — UX concern
**Affected file**: `src/pages/blog/index.astro`
**Current state**: All 98 entries (23 posts + 75 link roundups) rendered on a single page, grouped by year.

**Why escalated**: The sprint plan notes "Consider pagination if the combined 98 posts make the page too long." The builder implemented year-based grouping (which helps significantly), but no pagination was added. Whether this is acceptable is subjective — the page is long but scannable due to grouping.

**Decision needed from Greg**: Review the blog index page at `/blog`. If the length feels unwieldy, pagination using DaisyUI's pagination components can be added. If year-grouping is sufficient, no change is needed.

**Note**: The year-grouping implementation is well-executed and years collapse the visual complexity considerably. This may not need pagination at all.

---

## [INFO-5] Blog post meta descriptions fall back to title — affects SEO and social previews

**Severity**: Info — content work required
**Affected files**: All 23 blog posts in `src/content/blog/`
**Current behavior**: `description={post.data.description ?? \`${post.data.title} by Greg Brewer\`}` — since no posts have a `description` frontmatter field, every post's meta description is `"Post Title by Greg Brewer"`.

**Why escalated**: Writing 23 unique descriptions is content work that only Greg (or someone working with Greg) can do. Each description should be 120-160 characters summarizing the post. This is not a code problem — the code correctly falls back — but the fallback quality is poor for SEO and social sharing.

**Decision needed from Greg**: Determine whether to:
1. Write descriptions for each post manually (add `description:` to each file's frontmatter)
2. Auto-generate descriptions from post content (requires code to extract first paragraph)
3. Accept the fallback as "good enough" for now

**Recommendation**: At minimum, add descriptions to the 5-10 most linked/visible posts. The older 2012-2014 posts likely receive minimal traffic and can wait.
