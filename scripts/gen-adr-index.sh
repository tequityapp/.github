#!/usr/bin/env bash
# Generates the reverse-chronological ADR index table in docs/decisions/README.md
# from each NNNN-*/README.md — its `# NNNN — Title` H1 and `- **Date:**` line — so
# no PR ever hand-edits the shared table (add an ADR directory; the table is derived).
#
#   scripts/gen-adr-index.sh          # rewrite the table in place (between markers)
#   scripts/gen-adr-index.sh --check  # exit 1 if the committed table is stale
#
# The H1 is the canonical decision statement, so the index can never drift from it.
# Pure bash + awk. Clean reimplementation of the verjson/.github generator contract.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
dec_dir="$root/docs/decisions"
index="$dec_dir/README.md"
begin='<!-- BEGIN ADR INDEX -->'
end='<!-- END ADR INDEX -->'

gen_table() {
  printf '| # | Date | Decision |\n'
  printf '|---|------|----------|\n'
  local dir slug num readme h1 title date
  while IFS= read -r dir; do
    slug="$(basename "$dir")"
    num="${slug%%-*}"
    readme="$dir/README.md"
    if [ ! -f "$readme" ]; then
      echo "gen-adr-index: $slug/README.md not found" >&2
      exit 1
    fi
    h1="$(awk '/^#[[:space:]]+[0-9]+[[:space:]]/ { sub(/^#[[:space:]]+/, ""); print; exit }' "$readme")"
    date="$(awk '/^-[[:space:]]+\*\*Date:\*\*/ { sub(/^-[[:space:]]+\*\*Date:\*\*[[:space:]]*/, ""); print; exit }' "$readme")"
    title="${h1#* }"    # drop the leading "NNNN "
    title="${title#* }" # drop the leading dash token ("—" or "-") and its space
    if [ -z "$h1" ] || [ -z "$date" ] || [ -z "$title" ]; then
      echo "gen-adr-index: $slug/README.md missing a '# NNNN — Title' H1 or '- **Date:**' line" >&2
      exit 1
    fi
    printf '| [%s](%s/README.md) | %s | %s |\n' "$num" "$slug" "$date" "$title"
  done < <(find "$dec_dir" -mindepth 1 -maxdepth 1 -type d -name '[0-9][0-9][0-9][0-9]-*' | sort -r)
}

render() {
  local tmp
  tmp="$(mktemp)"
  gen_table >"$tmp"
  awk -v tf="$tmp" -v b="$begin" -v e="$end" '
    $0 == b { print; while ((getline line < tf) > 0) print line; close(tf); skip = 1; next }
    $0 == e { skip = 0; print; next }
    !skip   { print }
  ' "$index"
  rm -f "$tmp"
}

if ! grep -qF "$begin" "$index" || ! grep -qF "$end" "$index"; then
  echo "gen-adr-index: both markers must be present in $index" >&2
  exit 1
fi

if [ "${1:-}" = "--check" ]; then
  if ! diff -u "$index" <(render) >/dev/null; then
    echo "gen-adr-index: docs/decisions/README.md is stale — run scripts/gen-adr-index.sh and commit." >&2
    exit 1
  fi
  echo "ADR index is up to date."
else
  render >"$index.tmp" && mv "$index.tmp" "$index"
  echo "Regenerated ADR index in $index"
fi
