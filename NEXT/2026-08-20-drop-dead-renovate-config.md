# Drop the dead repository-level Renovate config

Date: 2026-08-20 · PR: #4

`renovate.json` here declared only `extends: ["config:recommended"]`. That is a
strict subset of the organization policy in `tequityapp/renovate-config`, whose
`default.json` extends the same preset **and** carries the `npm.pkg.github.com`
hostRule plus `npmrc` that let Renovate resolve the private `@verjson/*` and
`@tequityapp/*` packages. Keeping a local file therefore bought nothing and cost
the private-registry credential for this repository.

Every other repository in the organization already carries no `renovate.json`
and inherits policy through `org-inherited-config.json`; this was the last one
out of step. Nothing extended it — an organization-wide search for
`local>tequityapp/.github` returns no referents — so removing it changes no
other repository's resolution.
