#!/usr/bin/env bash
set -euo pipefail

LOGFILE="$HOME/Server/focus_log.txt"
STATEFILE="$HOME/Server/.focus_state"

MINUTES=${1:-20}
TASK_NAME=${2:-"Unnamed Task"}
DURATION=$(( MINUTES * 60 ))

# --- Active-lock guard ---
if [ -f "$STATEFILE" ]; then
    echo "⚠️ Already focusing on: $(cat "$STATEFILE")"
    exit 1
fi
echo "$TASK_NAME" > "$STATEFILE"

# --- Logging start ---
START_TIME=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$START_TIME] START - $TASK_NAME" >> "$LOGFILE"

sleep 5

# --- Store active window like your Hypr version ---
WIN_ID=$(xdotool getactivewindow 2>/dev/null || echo "")

# --- Disable keybindings ---
DISABLE_KEYS=(
  switch-applications
  switch-windows
  toggle-overview
  show-desktop
  cycle-windows
  cycle-group
  switch-to-workspace-left
  switch-to-workspace-right
)

for key in "${DISABLE_KEYS[@]}"; do
  gsettings set org.gnome.desktop.wm.keybindings "$key" "[]"
done
for key in "${DISABLE_KEYS[@]}"; do
  gsettings set org.gnome.shell.keybindings "$key" "[]"
done

# --- GNOME: Kill panel/dock equivalents (optional) ---
# Commented by default because GNOME Shell survives restarts badly.
# Uncomment if you want them hidden during focus.
# nohup pkill gnome-panel 2>/dev/null || true
# nohup pkill dash-to-dock 2>/dev/null || true

notify-send "🔒 Focus Mode Started" "\"$TASK_NAME\" for ${MINUTES} minutes. Stay on task."

# --- Loop: force window focus (Hypr-like behavior) ---
(
while true; do
    ACTIVE=$(xdotool getactivewindow 2>/dev/null || echo "")
    if [ "$ACTIVE" != "$WIN_ID" ]; then
        wmctrl -ia "$WIN_ID" 2>/dev/null || true
    fi
    sleep 0.2
done
) & LOCK_PID=$!

# --- Timer block ---
for ((i=MINUTES; i>0; i--)); do
    if (( i % 5 == 0 )); then
        notify-send -t 1000 "Focus Mode" "$i minute(s) left..."
    fi
    sleep 60
done

# --- Cleanup ---
kill "$LOCK_PID" 2>/dev/null || true

# Restore all keybinds
gsettings reset-recursively org.gnome.desktop.wm.keybindings
gsettings reset-recursively org.gnome.shell.keybindings

# Remove state
rm -f "$STATEFILE"

# --- Log end ---
END_TIME=$(date '+%Y-%m-%d %H:%M:%S')
DURATION_REAL=$(($(date +%s) - $(date -d "$START_TIME" +%s)))
MINS=$((DURATION_REAL / 60))

echo "[$END_TIME] STOP  - $TASK_NAME (Duration: ${MINS}m)" >> "$LOGFILE"
notify-send "✅ Focus Unlocked" "\"$TASK_NAME\" completed after ${MINS} minutes."

exit 0
