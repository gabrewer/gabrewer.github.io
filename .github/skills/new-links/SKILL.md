---
name: new-links
description: Create a new daily Useful Links post. Paste URLs and Claude organizes them into categories with a Quote of the Day.
disable-model-invocation: false
argument-hint: "[paste URLs or describe what you have]"
---

You are creating a new daily Useful Links post for gabrewer.com.

## What You Need From Greg

If Greg hasn't already provided them, ask for:
1. **URLs** — a list of links to include (can be raw URLs, or URLs with titles)
2. **Quote of the Day** (optional) — a quote and attribution. If not provided, pick an inspiring one related to engineering, leadership, or growth.

## How to Create the Post

### Step 1: Fetch Link Titles

For each URL provided, use WebFetch to get the page title. If WebFetch fails, ask Greg for the title or use the URL path to infer one.

### Step 2: Categorize

Organize the links into categories. Use categories from previous posts as a guide. Common categories include:

- AI
- Software Development
- Testing
- Web and Cloud Development
- DotNet
- Leadership/Management
- Business
- Personal Development
- Database
- DevOps
- Architecture
- Tools

Only include categories that have links. Don't force links into categories that don't fit — create new ones if needed.

### Step 3: Write the File

**Filename**: `src/content/links/YYYY-MM-DD.md` using today's date.

**Format** — follow this exact structure:

```markdown
---
title: "Links - MM/DD/YYYY"
date: YYYY-MM-DDTHH:MM:SS -05:00
comments: false
categories: ["links"]
tags: ["links"]
---

#### Quote of the Day

<blockquote>"The quote text here."<br>
--  Attribution Name
</blockquote>

#### Category Name
[Link Title](https://url.com)

[Another Link Title](https://another-url.com)

#### Another Category
[Link Title](https://url.com)
```

Key rules:
- Each link is a bare markdown link on its own line (NOT a list item, NOT indented)
- Blank line between links within a category
- No blank line between the category header and the first link
- Empty categories (header with no links) should be omitted
- The date in the title uses MM/DD/YYYY format
- The date in frontmatter uses ISO format with timezone offset

### Step 4: Verify

Run `npm run build` to make sure it compiles.

### Step 5: Confirm

Show Greg the post and ask if he wants to adjust categories, add/remove links, or change the quote. Make edits as requested, then ask if he wants to commit.

### Step 6: Commit (if requested)

```
git add src/content/links/YYYY-MM-DD.md
git commit -m "links: YYYY-MM-DD daily useful links

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>"
```
