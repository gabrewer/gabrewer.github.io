# Repair GitHub Pages dependency installation

- Run `40266327934` failed at `npm ci` because the lockfile omitted `@emnapi/core@1.11.3` and `@emnapi/runtime@1.11.1`.
- Added only those two registry-resolved entries, including integrity hashes and transitive dependencies. No dependency versions or package.json requirements changed.
- Verified `npm ci` followed by `npm run build` in an isolated clean checkout using Node 22.23.4 and npm 10.9.9, matching the workflow's Node 22/npm 10 toolchain. Validation was on Windows, not the Ubuntu runner.
- The initial in-place clean install hit a Windows lock on the lightningcss native module; isolated validation avoided interrupting the process holding that file.
- npm reported 15 existing audit findings. Dependency upgrades are outside this narrow CI repair.
