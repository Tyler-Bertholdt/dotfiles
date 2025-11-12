#!/usr/bin/env bash
# hypr-window-switcher.sh
# List Hyprland windows, let you pick one via wofi, then focus it.
# Requirements: hyprctl, wofi. jq is recommended but not required.

set -euo pipefail

LAUNCHER_CMD="wofi --show dmenu --prompt 'Windows'"

# produce a newline-separated list of "ADDRESS CLASS - TITLE"
get_entries_json() {
  # prefer JSON if hyprctl supports -j
  if hyprctl -j clients >/dev/null 2>&1; then
    if command -v jq >/dev/null 2>&1; then
      hyprctl -j clients | jq -r '.[] | "\(.address) \(.class) - \(.title)"'
    else
      # fallback to python if jq isn't available
      hyprctl -j clients | python3 - <<'PY'
import sys, json
j = json.load(sys.stdin)
out = []
for x in j:
    addr = x.get("address") or x.get("address_hex") or ""
    cls = x.get("class") or ""
    title = x.get("title") or ""
    out.append(f"{addr} {cls} - {title}")
sys.stdout.write("\n".join(out))
PY
    fi
  else
    return 1
  fi
}

# fallback parser for older hyprctl (plain text)
get_entries_plain() {
  # hyprctl clients prints lines containing "address:" and title/class; this is a simple best-effort parse
  hyprctl clients 2>/dev/null | awk '
  BEGIN{FS="address:"}
  /address:/{
    addr=$2
    gsub(/^ +| +$/,"",addr)
    # try to find title and class from the line (best-effort)
    title=""; cls=""
    # reconstruct a readable line
    if (match($0,/class: *[^ ]+/)) {
      cls=substr($0, RSTART+6, RLENGTH-6)
    }
    if (match($0,/title: */)) {
      t=substr($0, RSTART)
      sub(/^title: */,"",t)
      title=t
    }
    print addr " " cls " - " title
  }'
}

# get list
entries="$(get_entries_json 2>/dev/null || get_entries_plain 2>/dev/null || true)"

# nothing to choose
if [ -z "$entries" ]; then
  echo "No windows found (is Hyprland running and do you have windows?)." >&2
  exit 0
fi

# show in launcher
selection="$(printf '%s\n' "$entries" | ${LAUNCHER_CMD})" || exit 0

# extract address (first token)
address="$(printf '%s' "$selection" | awk '{print $1}')"

# sanitize address a bit (remove trailing punctuation)
address="$(printf '%s' "$address" | sed -E 's/[^0-9a-zA-Zx:_.-].*$//')"

if [ -z "$address" ]; then
  echo "No selection." >&2
  exit 0
fi

# focus the chosen window
hyprctl dispatch focuswindow address:"$address"
