# 0002 — Port functional CI conventions tooling; defer the infra-coupled merge gate

- **Date:** 2026-07-22
- **Status:** Accepted
- **Category:** Governance / CI

## Context

When bootstrapping `tequityapp/.github` we set out to reuse verjson's shared
CI/governance layer. Inspecting it showed it is pervasively coupled to
infrastructure `tequityapp` does not have:

- Reusable workflows (`node-ci`, `node-release`, `helm-ci`, `ui-ci`,
  `pulumi-ci`, `tag-major`) and the AI merge gate route on verjson's self-hosted
  runner fleet — `runs-on: [self-hosted, GCP, gate, meta]`.
- The gate depends on an org `main-protection` ruleset, an `ANTHROPIC_API_KEY`
  secret, a shared `renovate-config` preset, and a `verjson-observability`
  telemetry action.
- `ai-review-merge.yml` is ~56 KB of **security-sensitive auto-merge automation**
  (it squash-merges PRs using an org-admin ruleset bypass).

Copied verbatim, these would be inert (no matching runners/secrets/ruleset) and,
for the gate, unsafe to run mis-adapted in a fresh org.

## Decision

Port only the pieces that function on GitHub-hosted runners with no org wiring:

- `scripts/render-next.sh` (verbatim) and a clean reimplementation of
  `scripts/gen-adr-index.sh`, backing the `NEXT/` and ADR conventions.
- `.github/workflows/actionlint.yml` (on `ubuntu-latest`) and
  `.github/workflows/adr-index.yml` (fails a PR when the ADR index is stale).

Do **not** copy the merge gate or the self-hosted reusable CI/release workflows.
Document how to adopt them in [`SETUP.md`](../../../SETUP.md), pointing at
[`verjson/.github`](https://github.com/verjson/.github) as the reference
implementation.

## Consequences

- The `NEXT/` and ADR conventions are enforced in CI from day one.
- Adopting the full gate is a deliberate, human-reviewed follow-up — it touches
  branch protection, org rulesets, and auto-merge, which are sensitive-class
  changes that must not be bulk-copied.
- No inert or mis-adapted security automation ships into the organization.
