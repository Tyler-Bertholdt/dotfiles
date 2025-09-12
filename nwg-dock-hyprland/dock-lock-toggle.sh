
#!/usr/bin/env bash
# Toggle "lock" for auto-hide. When locked -> dock stays visible and watcher does nothing.
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nwg-dock-hyprland"
LOCKFILE="$CONFIG_DIR/auto-disable.lock"
PIDNAME="nwg-dock-hyprland"

if [[ -f "$LOCKFILE" ]]; then
  rm -f "$LOCKFILE"
  # allow watcher to resume - we don't hide immediately (it will do its job)
  notify-send "Dock autohide" "Auto-toggle enabled"
  exit 0
else
  mkdir -p "$CONFIG_DIR"
  touch "$LOCKFILE"
  # Show dock immediately and keep it shown until unlocked.
  pkill -RTMIN+2 -x "$PIDNAME" 2>/dev/null || true
  notify-send "Dock locked" "Dock will stay visible until you toggle again"
  exit 0
fi
