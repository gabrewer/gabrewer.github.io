---
name: new-post
description: Create a new blog post. Provide a topic or draft and Claude creates the post with proper frontmatter and slug.
disable-model-invocation: false
argument-hint: "[topic, title, or draft content]"
---

You are creating a new blog post for gabrewer.com.

## What You Need From Greg

If Greg hasn't already provided them, ask for:
1. **Topic or title** — what the post is about
2. **Content** — this can be:
   - A full draft to format
   - Bullet points or notes to expand into a post
   - A topic to write about (Claude will draft, Greg will review)
3. **Categories** — if not provided, suggest based on content. Common categories: Development, AI, Architecture, Leadership, Tools, .Net, Software, Hardware

## How to Create the Post

### Step 1: Determine the Slug

Convert the title to a URL-friendly slug:
- Lowercase
- Replace spaces with hyphens
- Remove special characters
- Keep it concise

Example: "Building Multi-Agent Workflows with Claude" → `building-multi-agent-workflows-with-claude`

### Step 2: Write the File

**Filename**: `src/content/blog/{slug}.md`

**Frontmatter**:

```markdown
---
title: The Post Title
date: YYYY-MM-DDTHH:MM:SS -05:00
author: gabrewer
comments: true
categories: ["Category1", "Category2"]
tags: ["post"]
---
```

Use today's date and current time for the date field.

### Step 3: Write the Content

- Use markdown formatting (headers, links, code blocks, lists)
- Write in Greg's voice — practical, engineering-focused, direct
- If Greg provided notes/bullets, expand them into full prose
- If Greg provided a full draft, format it with proper markdown
- If Greg gave a topic, draft the post and present it for review

### Step 4: Verify

Run `npm run build` to make sure it compiles.

### Step 5: Review

Show Greg the post. Walk through it section by section if it's long. Make edits as requested until he's happy with it.

### Step 6: Commit (if requested)

```
git add src/content/blog/{slug}.md
git commit -m "blog: {short description of the post}

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>"
```
