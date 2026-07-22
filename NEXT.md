<!--
  This file is a static pointer — do NOT add changelog entries here.
  To avoid merge conflicts on a shared, prepend-only changelog when PRs are in
  flight, this repo keeps its running log as one file per entry under NEXT/.
  Add an entry as a new fragment; you never touch a shared file, so two PRs
  never conflict on the log.
-->

# NEXT — running log (fragment-based)

The running log lives in [`NEXT/`](NEXT/) as one markdown file per entry.

- **Add an entry:** create `NEXT/YYYY-MM-DD-<slug>.md` in the same commit as the
  change (see [`NEXT/README.md`](NEXT/README.md) for the format). Do not edit a
  shared changelog file — that's the whole point.
- **Read the whole log, newest first:** `scripts/render-next.sh` (added with the
  CI tooling).
