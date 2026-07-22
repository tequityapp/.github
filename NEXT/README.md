# NEXT/ — running-log fragments

This directory is the organization `.github` repo's running log. Each change
adds **one file** here, so concurrent PRs never collide on a shared changelog.

## Adding an entry

Create a file named `YYYY-MM-DD-<slug>.md` in the **same commit** as your change:

```markdown
# <short title>

Date: YYYY-MM-DD · PR: #<n>

What changed and why (one short paragraph). Link issues/ADRs if relevant.
```

## Reading the log

Use `scripts/render-next.sh` (added with the CI tooling) to render every
fragment newest-first. Never hand-edit a generated changelog — add a fragment
and regenerate.
