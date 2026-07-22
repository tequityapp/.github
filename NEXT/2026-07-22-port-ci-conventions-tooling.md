# Port functional CI conventions tooling; document the deferred gate

Date: 2026-07-22

Added the parts of verjson's CI/governance layer that work on GitHub-hosted
runners with no org wiring: `render-next.sh` and a clean reimplementation of
`gen-adr-index.sh` (backing the `NEXT/` and ADR conventions), an `actionlint`
workflow, and an `adr-index` staleness check. The infra-coupled reusable
workflows and the 56 KB AI merge gate were not copied — [`SETUP.md`](../SETUP.md)
documents how to adopt them. See ADR-0002.
