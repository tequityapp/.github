# CI / governance setup

This repository carries Tequity's shared CI and governance conventions in two
tiers.

## Works today (GitHub-hosted, nothing to provision)

| Piece | What it does |
| --- | --- |
| `scripts/render-next.sh` | Renders the [`NEXT/`](NEXT) running log, newest first. |
| `scripts/gen-adr-index.sh` `[--check]` | Regenerates / verifies the ADR index table in [`docs/decisions/README.md`](docs/decisions/README.md). |
| `.github/workflows/actionlint.yml` | Lints all workflows on every change (pinned, checksum-verified binary). |
| `.github/workflows/adr-index.yml` | Fails a PR if the ADR index table is stale. |

These run on `ubuntu-latest` and need no secrets, runners, or rulesets.

## Deferred — the verjson reusable-workflow + merge-gate stack

[`verjson/.github`](https://github.com/verjson/.github) ships an org-wide AI
merge gate (`ai-review-merge.yml`) plus reusable CI/release workflows
(`node-ci`, `node-release`, `helm-ci`, `ui-ci`, `pulumi-ci`, `tag-major`). They
were **not** copied here: they depend on infrastructure `tequityapp` does not
have, and the merge gate is security-sensitive auto-merge automation that must be
adopted deliberately, not bulk-copied (see [ADR-0002](docs/decisions/0002-port-functional-ci-tooling-defer-merge-gate/README.md)).

To adopt them, provision:

1. **Runners.** verjson's workflows route on self-hosted pools
   (`runs-on: [self-hosted, GCP, gate, meta]`). Either stand up equivalent
   runner groups, or fork the workflows to `ubuntu-latest`.
2. **Org ruleset.** A `main-protection` ruleset that requires the gate's status
   check on every repo, with an org-admin bypass so the gate can squash-merge.
3. **Secrets.** `ANTHROPIC_API_KEY` for the AI review, plus any deploy /
   observability secrets the CI workflows reference.
4. **Renovate preset.** A shared preset (verjson uses
   `github>Verjson/renovate-config`); create `tequityapp/renovate-config` or
   inline the rules into `renovate.json`.
5. **Observability.** verjson's CI telemetry uses a `verjson-observability`
   action; wire an equivalent or drop the telemetry steps.

Because the merge gate touches branch protection, org rulesets, and auto-merge,
treat its adoption as a **sensitive change**: land it behind human review and
record an ADR.
