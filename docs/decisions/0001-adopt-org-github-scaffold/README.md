# 0001 — Adopt org profile + community-health + CI/governance scaffold

- **Date:** 2026-07-22
- **Status:** Accepted
- **Category:** Governance / repository conventions

## Context

The `tequityapp` organization had no `.github` repository, so it had no public
org profile, no default community-health files, and no shared place for
cross-repo CI and governance conventions. We wanted a consistent baseline that
matches Tequity's public brand and reuses the conventions already proven in
[`verjson/.github`](https://github.com/verjson/.github) (Tequity is built on the
verJSON platform toolchain).

## Decision

Create `tequityapp/.github` with:

- A **Tequity-branded org profile** (`profile/README.md`) — magenta `#E2187D`,
  dark, logo from tequity.site; copy anchored on the site's "Secure Data Rooms"
  positioning.
- The **standard community-health set** — Code of Conduct, Contributing,
  Security Policy, Support, issue/PR templates, FUNDING.
- A **self-contained GitHub Pages landing** (`index.html`).
- **Fragment-based running-log** (`NEXT/`) and **ADR** (`docs/decisions/`)
  conventions, seeded fresh for this org rather than copied from verjson's
  history.

The shared CI/governance tooling (reusable workflows, gate scripts) is ported
separately and requires org-level wiring before it functions.

## Consequences

- Every Tequity repo without its own community-health files inherits these.
- The org profile page renders Tequity's brand publicly.
- verjson's *decision history and changelog* are intentionally **not** copied —
  they record verjson's decisions, not Tequity's. Only the conventions and
  tooling are reused.
