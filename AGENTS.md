# Project instructions for pi

This repository uses **pi** as the coding-agent harness.

## Common commands

- `npm run dev` — start Astro dev server
- `npm run build` — build the static site
- `npm run preview` — preview the built site
- `./scripts/build.sh landingpage --plan-only` — generate/update the sprint plan with pi
- `./scripts/build.sh landingpage --only <sprint-slug>` — run one sprint through build/destroy/review with pi

## Project conventions

- This is an Astro static site using Tailwind CSS 4 and DaisyUI 5.
- Prefer DaisyUI semantic classes over hardcoded colors.
- Keep content in source files and Astro content collections.
- Leave breadcrumbs for significant agent decisions under `breadcrumbs/<feature>/<sprint>/`.

## pi resources

Project skills live in `.pi/skills/` and are available as `/skill:<name>` in pi.
The unattended build pipeline in `scripts/build.sh` invokes pi directly and loads those same skill instructions.
