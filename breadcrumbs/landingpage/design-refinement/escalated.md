# Escalated Items — landingpage/design-refinement

**Date**: 2026-03-10
**Escalated by**: Review Agent
**Reason for escalation**: These items require Greg's explicit decision — they are either design intent questions or content confirmations that cannot be auto-resolved.

---

## [WARN-4] LessiFeature: Floating Island vs. True Full-Bleed Stripe

**File**: `src/pages/index.astro` + `src/components/landing/LessiFeature.astro`

**What the Destroyer found:**
The `<LessiFeature />` section has `bg-primary` coloring but sits inside an outer `<div class="py-16 space-y-16">` wrapper. The `space-y-16` (4rem = 64px) creates visible `bg-base-100` gaps above and below the colored section:

```
[Hero + StatusLine zone]
[4rem bg-base-100 gap ← space-y-16]
[bg-primary section with py-14 internal padding]
[4rem bg-base-100 gap ← space-y-16]
[Speaking/Posts/Connect zone]
```

This creates a **floating island** effect, not a **full-bleed horizontal stripe** that runs edge-to-edge vertically.

**Why this needs Greg's decision:**
The builder's stated intent was a "visual peak" — the thing your eye is drawn to. The current implementation achieves this as an island. But the sprint task description says "full-width colored block that breaks the monotony" — which could mean island OR stripe depending on interpretation.

On dark themes (Abyss, Synthwave, Luxury), a floating `bg-primary` island against a dark `bg-base-100` canvas may feel disconnected rather than impactful.

**Two options:**

**Option A — Keep the island (no change needed)**
Leave `index.astro` as-is. The 4rem breathing room above/below is intentional. The LessiFeature section already uses `max-w-4xl` to break out of the `max-w-2xl` column, which gives width contrast. The island look works on light themes.

**Option B — True full-bleed stripe (requires a code change)**
Remove `<LessiFeature />` from the `space-y-16` wrapper and restructure `index.astro`:
```astro
<div class="py-16 space-y-16">
  <div class="max-w-2xl mx-auto px-4 space-y-8">
    <Hero />
    <StatusLine />
  </div>
</div>

<!-- True full-bleed: no space-y-16 gap above or below -->
<LessiFeature />

<div class="py-16 space-y-16">
  <div class="max-w-2xl mx-auto px-4 space-y-16">
    <Speaking />
    ...
  </div>
</div>
```

**Recommendation**: Review both options visually across light and dark themes before deciding. The floating island works well on `light` and `caramellatte`; on `abyss` or `synthwave` it may look better as a full-bleed stripe.

**Action needed**: Greg to confirm whether the current island look is acceptable, or request the full-bleed restructure.

---

## [WARN-5] Email Address Confirmation Required Before Launch

**Files**: `src/components/landing/Connect.astro` (line 30), `src/pages/about.astro` (line 221)

**What the Destroyer found:**
The contact email `greg@gabrewer.com` is hardcoded in two places. The PRD explicitly flags this as unresolved:

> *Open Question #3 — which email for the contact link? Use a placeholder `mailto:` until Greg decides.*

**Why this needs Greg's decision:**
This is not a code issue — it's a content confirmation. The email `greg@gabrewer.com` is either:
1. Greg's intended contact email (in which case no change needed — just confirm it)
2. A placeholder the builder filled in without explicit confirmation (in which case it needs to be updated to the correct address before the site goes live)

**Risk**: If the wrong email deploys, Greg may miss real contact attempts from potential clients, speakers, or collaborators who reach out via the site.

**Action needed**: Greg to confirm `greg@gabrewer.com` is the correct contact email (or provide the correct one). Once confirmed, no code change is needed — just mark this resolved.

---

## Breadcrumb

- **Who**: Review Agent
- **What**: Two items escalated that require owner input — one design intent question, one content confirmation
- **Why**: Both items could go either way. Auto-fixing them would mean making assumptions about design intent and email address that could be wrong. Better to surface them explicitly
- **Confidence**: Medium — the underlying facts are clear; only the preferred outcome is unknown
