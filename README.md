# .github

Tequity's organization-level GitHub configuration — visible to anyone.

This repository holds three things:

1. **Org profile** — [`profile/README.md`](profile/README.md) renders on the
   [organization landing page](https://github.com/tequityapp). Branding follows
   [tequity.site](https://tequity.site); its logo lives in
   [`profile/assets/`](profile/assets).
2. **Community-health files** — default `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md`,
   `SECURITY.md`, `SUPPORT.md`, issue/PR templates, and `FUNDING.yml`. GitHub
   applies these to every Tequity repo that doesn't define its own.
3. **Shared CI / governance tooling** — reusable workflows, gate scripts, and
   the ADR + running-log conventions used across the org. The workflow layer
   requires org-level wiring before it does anything (see `SETUP.md`, added with
   the tooling); until then it is inert and fail-closed.

## Conventions

- **Running log** — one fragment per change under [`NEXT/`](NEXT), rendered by
  `scripts/render-next.sh`. Never hand-edit a shared changelog; add a fragment.
- **Decision records** — architecturally significant, hard-to-reverse decisions
  are captured as ADRs under [`docs/decisions/`](docs/decisions), indexed in
  [`docs/decisions/README.md`](docs/decisions/README.md).

Structure follows [`verjson/.github`](https://github.com/verjson/.github).
