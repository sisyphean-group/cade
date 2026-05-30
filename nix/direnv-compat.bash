#!@bash@/bin/bash
# direnv shim: maps the direnv cli surface tools rely on onto cade calls.
# drop on PATH as `direnv`. unknown subcommands are silent no-ops
set -u

cade=@cade@

cmd=${1:-}
target=${2:-}

case $cmd in
  export)
    case ${target:-bash} in
      json)
        out=$("$cade" reload --shell json 2>/dev/null) || true
        [ -n "$out" ] || out='{}'
        printf '%s\n' "$out"
        ;;
      bash | zsh | fish | nushell | nu)
        "$cade" reload --shell "${target:-bash}" 2>/dev/null || true
        ;;
    esac
    ;;
  hook)
    "$cade" hook "${target:-bash}"
    ;;
  allow | permit | grant)
    "$cade" allow
    ;;
  deny | block | revoke)
    "$cade" disallow
    ;;
  status)
    "$cade" status
    ;;
  version)
    # satisfy version-gated callers
    echo "2.34.0"
    ;;
esac
exit 0
