# Decision log

Reverse-chronological index of org-level decisions.

> The table below is **generated** from each `NNNN-*/README.md` by
> `scripts/gen-adr-index.sh` (each row is the ADR's `# NNNN — Title` H1 + its
> `**Date:**`). Do not hand-edit it — add your ADR directory and run the script;
> the `adr-index` workflow fails if the committed table is stale. This keeps
> concurrent ADR PRs from conflicting on a shared table.

<!-- BEGIN ADR INDEX -->
| # | Date | Decision |
|---|------|----------|
| [0002](0002-port-functional-ci-tooling-defer-merge-gate/README.md) | 2026-07-22 | Port functional CI conventions tooling; defer the infra-coupled merge gate |
| [0001](0001-adopt-org-github-scaffold/README.md) | 2026-07-22 | Adopt org profile + community-health + CI/governance scaffold |
<!-- END ADR INDEX -->

## When to write an ADR (vs a GitHub issue)

An **issue** tracks *work* — transient, open→closed, "what needs doing / is it done".
An **ADR** records a *decision* — durable, "why is it this way, what did we rule out".
An issue's value ends when it closes; an ADR's begins there — so decision rationale must
not live only in issue comments (they rot and aren't versioned with the code).

Default flow:

1. **An issue is the front door** — bugs, tasks, and proposals start as issues (triage,
   discussion, backlog).
2. **Write an ADR only when the resolution locks in an architecturally-significant or
   hard-to-reverse decision** (auth/RBAC, rulesets/branch protection, IAM/OIDC, secrets,
   runner topology, anything destructive — always). A bug fix, dependency bump, or "adopt
   the existing pattern" needs no ADR.
3. **Wire them both ways** — the ADR's Context cites the issue #; the issue links the ADR;
   the implementing PR links both (*what* = issue, *why* = ADR).
4. **Close the issue on merge; the ADR persists.**
5. **Never edit a decided ADR to reverse it** — add a new ADR that supersedes it and link
   both.

Format: one directory per decision, `NNNN-kebab-title/README.md` (next zero-padded number).
Run `scripts/gen-adr-index.sh` to refresh the table above (newest first).
