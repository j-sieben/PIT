#!/bin/bash
# Emit validated SQL*Plus definitions, or export a clean release directory.
set -euo pipefail
VERSION_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)"
fail() { echo "PIT version: $*" >&2; exit 1; }
base="$(cat "${VERSION_ROOT}/VERSION")"
[[ "$base" =~ ^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$ ]] || fail 'VERSION must contain Major.Minor.'
if [ -e "${VERSION_ROOT}/.git" ]; then
  command -v git >/dev/null || fail 'Git is required for this checkout.'
  [ "$(git -C "$VERSION_ROOT" rev-parse --show-toplevel)" = "$VERSION_ROOT" ] || fail 'Invalid Git checkout root.'
  commit="$(git -C "$VERSION_ROOT" rev-parse --verify 'HEAD^{commit}')"
  [ "$(git -C "$VERSION_ROOT" rev-parse --is-shallow-repository)" = false ] || fail 'Incomplete Git history (shallow clone); fetch the complete history first.'
  if git -C "$VERSION_ROOT" config --get-regexp '^(extensions\.partialclone|remote\..*\.promisor)$' >/dev/null; then
    fail 'Partial clones are unsupported; use a complete checkout.'
  else
    [ $? -eq 1 ] || fail 'Cannot inspect Git partial clone configuration.'
  fi
  replacements="$(git -C "$VERSION_ROOT" for-each-ref --format='%(refname)' refs/replace)" || fail 'Cannot inspect Git replacement refs.'
  [ -z "$replacements" ] || fail 'Git replace refs are unsupported.'
  grafts="$(git -C "$VERSION_ROOT" rev-parse --git-path info/grafts)"
  case "$grafts" in /*) ;; *) grafts="${VERSION_ROOT}/${grafts}" ;; esac
  [ ! -s "$grafts" ] || fail 'Git grafts are unsupported.'
  changes="$(git -C "$VERSION_ROOT" status --porcelain --untracked-files=all)" || fail 'Cannot inspect Git working tree.'
  [ -z "$changes" ] || fail 'Local changes found; commit or remove them before installation/export.'
  git -C "$VERSION_ROOT" diff --quiet "$commit" -- || fail 'Working tree differs from the selected commit.'
  git -C "$VERSION_ROOT" diff --cached --quiet "$commit" -- || fail 'Index differs from the selected commit.'
  git -C "$VERSION_ROOT" --no-replace-objects fsck --connectivity-only --no-reflogs "$commit" >/dev/null || fail 'Git history or objects are incomplete/corrupt.'
  count="$(git -C "$VERSION_ROOT" --no-replace-objects rev-list --count "$commit")" || fail 'Cannot count commits; Git history is incomplete/corrupt.'
  version="${base}.${count}"
else
  [ -f "${VERSION_ROOT}/.pit-version" ] || fail 'No Git checkout or prepared .pit-version metadata; use a prepared release export.'
  # Parse data only. Never source metadata as executable shell code.
  version="$(sed -n '1p' "${VERSION_ROOT}/.pit-version")"
  commit="$(sed -n '2p' "${VERSION_ROOT}/.pit-version")"
  [ "$(wc -l < "${VERSION_ROOT}/.pit-version" | tr -d ' ')" = 2 ] || fail 'Invalid .pit-version metadata.'
  [ "${version%.*}" = "$base" ] || fail 'Prepared version does not match VERSION.'
fi
[[ "$version" =~ ^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$ ]] || fail 'Invalid product version.'
[[ "$commit" =~ ^[0-9a-f]{40}$ || "$commit" =~ ^[0-9a-f]{64}$ ]] || fail 'Invalid full Git commit hash.'
case "${1:---sql}" in
  --sql)
    [ $# -le 1 ] || fail 'Usage: version.sh [--sql | --export NEW_DIRECTORY]'
    printf 'define PIT_VERSION=%s\ndefine PIT_GIT_COMMIT=%s\n' "$version" "$commit"
    ;;
  --export)
    [ $# -eq 2 ] || fail 'Usage: version.sh --export NEW_DIRECTORY'
    [ -e "${VERSION_ROOT}/.git" ] || fail 'Exports must originate from Git.'
    [ ! -e "$2" ] || fail 'Export destination already exists.'
    # An external destination also keeps the source checkout clean.
    parent="$(cd "$(dirname "$2")" && pwd -P)"
    case "${parent}/$(basename "$2")/" in "$VERSION_ROOT/"*) fail 'Export outside the source checkout.' ;; esac
    mkdir "$2"
    git -C "$VERSION_ROOT" archive --format=tar "$commit" | tar -xf - -C "$2"
    printf '%s\n%s\n' "$version" "$commit" > "$2/.pit-version"
    printf 'Exported PIT %s (%s) to %s\n' "$version" "$commit" "$2"
    ;;
  *) fail 'Usage: version.sh [--sql | --export NEW_DIRECTORY]' ;;
esac
