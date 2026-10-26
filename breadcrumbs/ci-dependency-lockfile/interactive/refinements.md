### Refinement: Restore optional peer runtime entries after PostHog install
- **Date**: 2026-10-26
- **Who**: Frontend Builder (interactive)
- **What**: Restored registry-verified @emnapi/core@1.11.3 and @emnapi/runtime@1.11.3 lock entries; switched the Pages build to Node 24 to satisfy Astro's engine requirement.
- **Why**: Deployment run 40420909027 failed at npm ci because both optional peer runtime entries were missing. The Windows build using existing node_modules did not catch the broken clean install. CI's Node 22.23.3 also fell below Astro 7.4.2's minimum Node 22.23.4.
- **Files changed**: package-lock.json, .github/workflows/deploy.yml
- **Alternatives considered**: Full lockfile regeneration rejected to avoid unrelated dependency churn. Retaining Node 22 rejected because the runner resolved an unsupported patch release.
- **Confidence**: high

Validation and targeted adversarial review:
- Reproduced npm ci failure in an isolated Debian Linux container before the fix using npm 10.9.9.
- After the fix, clean npm ci and npm run build passed with Node 24.22.1 using both npm 10.9.9 and npm 11.6.2 (115 pages each).
- Verified lockfile SHA-256 stayed unchanged through installation and builds; no existing package entries or package.json requirements were changed.
- Checked registry integrity hashes and transitive dependencies for both restored entries. Targeted review found no additional issues in the changed files; visual/accessibility/theme checks are not applicable to this dependency/CI-only repair.
- Local .env.example deletion intentionally left untouched and uncommitted.
