#!/usr/bin/env bash
# dock-float-autohide.sh
# Requirements: hyprctl, jq, pkill (procps)
# Place under: ~/.config/nwg-dock-hyprland/

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nwg-dock-hyprland"
LOCKFILE="$CONFIG_DIR/auto-disable.lock"    # if exists -> auto behaviour is disabled
PIDNAME="nwg-dock-hyprland"
POLL_INTERVAL=1        # seconds, change if you want lower/higher frequency

last_state=""  # "shown" or "hidden" - avoid spamming signals

show_dock() {
  # SIGRTMIN+2 -> show (per repo README)
  pkill -RTMIN+2 -x "$PIDNAME" 2>/dev/null || true
  last_state="shown"
}

hide_dock() {
  # SIGRTMIN+3 -> hide
  pkill -RTMIN+3 -x "$PIDNAME" 2>/dev/null || true
  last_state="hidden"
}

# Wait for nwg-dock resident to exist (optional)
sleep 1

while true; do
  # if user disabled auto behaviour, skip
  if [[ -f "$LOCKFILE" ]]; then
    sleep "$POLL_INTERVAL"
    continue
  fi

  # only run if dock process exists
  if ! pgrep -x "$PIDNAME" >/dev/null 2>&1; then
    sleep "$POLL_INTERVAL"
    continue
  fi

  # Get clients JSON (silent on stderr)
  clients_json=$(hyprctl clients -j 2>/dev/null) || clients_json=""

  if [[ -z "$clients_json" ]]; then
    # can't get data, skip
    sleep "$POLL_INTERVAL"
    continue
  fi

  # Count visible/mapped floating windows.
  # Accepts floating==1 or floating==true; mapped==1/true ensures window is shown.
  floating_count=$(printf "%s" "$clients_json" \
    | jq '[ .[] | select((.mapped==1 or .mapped==true) and (.floating==1 or .floating==true)) ] | length' 2>/dev/null || echo "0")

  if [[ "$floating_count" -gt 0 ]]; then
    # if not already shown, show
    if [[ "$last_state" != "shown" ]]; then
      show_dock
    fi
  else
    # no floating windows -> hide
    if [[ "$last_state" != "hidden" ]]; then
      hide_dock
    fi
  fi

  sleep "$POLL_INTERVAL"
done

