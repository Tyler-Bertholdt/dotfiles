#!/usr/bin/env bash
set -euo pipefail
LOGFILE="$HOME/Server/focus_log.txt"
STATEFILE="$HOME/Server/.focus_state"
MINUTES=${1:-20}
TASK_NAME=${2:-"Unnamed Task"}
DURATION=$(( MINUTES * 60 ))

if [ -f "$STATEFILE" ]; then
    echo "⚠️ Already focusing on: $(cat "$STATEFILE")"
    exit 1
fi
echo "$TASK_NAME" > "$STATEFILE"

START_TIME=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$START_TIME] START - $TASK_NAME" >> "$LOGFILE"

sleep 5
WINDOW_ADDR=$( nohup hyprctl activewindow -j | jq -r '.address' 2>/dev/null || echo "")
if [[ "$WINDOW_ADDR" != "null" && -n "$WINDOW_ADDR" ]]; then
        nohup hyprctl dispatch focuswindow address:$WINDOW_ADDR
fi

nohup pkill waybar 2>/dev/null || true
nohup pkill nwg-dock-hyprla 2>/dev/null || true

# Disabled keybindings
DISABLE_BINDS=(
  "SUPER,SPACE"
  "SUPER,B"
   "SUPER,1" "SUPER,2" "SUPER,3" "SUPER,4" "SUPER,5" "SUPER,6" "SUPER,7" "SUPER,8" "SUPER,9"
   "SUPER SHIFT,1" "SUPER SHIFT,2" "SUPER SHIFT,3" "SUPER SHIFT,4" "SUPER SHIFT,5" "SUPER SHIFT,6" "SUPER SHIFT,7" "SUPER SHIFT,8" "SUPER SHIFT,9"
  "SUPER,TAB" "ALT,SPACE" "ALT,F2"
  "SUPER,R" "SUPER,W" "SUPER,D" "SUPER,S" "SUPER,A"
  "CTRL_ALT,T"
   "ALT,D" 
  )
for n in {1..9}; do
  DISABLE_BINDS+=("SUPER,SHIFT,${n}")
done
for bind in "${DISABLE_BINDS[@]}"; do
  nohup hyprctl keyword unbind "$bind" 2>/dev/null || true
done

notify-send "🔒 Focus Mode Started" "\"$TASK_NAME\" for ${MINUTES} minutes. Stay on task."
nohup waybar -c ~/dotfiles/waybar/config2.jsonc & disown
for ((i=MINUTES; i>0; i--)); do
    if (( i % 5 == 0 )); then
        notify-send -t 1000 "Focus Mode" "$i minute(s) left..."
    fi
    sleep 60
done

nohup hyprctl reload
nohup pkill waybar 2>/dev/null || true
nohup waybar & disown
nohup nwg-dock-hyprland -w 5 -p bottom -mb 7 -lp start -l overlay -i 56 -ico ~/File_Save/manjaro-vector-logo-seeklogo/manjaro-seeklogo.png -c 'nwg-drawer -mb 0 -ml 0 -mt 0 -mr 0 -ovl -is 58 -closebtn none -spacing 30 -c 7 -nocats' & disown 
rm -f "$STATEFILE"

END_TIME=$(date '+%Y-%m-%d %H:%M:%S')
DURATION_REAL=$(($(date +%s) - $(date -d "$START_TIME" +%s)))
MINS=$((DURATION_REAL / 60))
echo "[$END_TIME] STOP  - $TASK_NAME (Duration: ${MINS}m)" >> "$LOGFILE"

notify-send "✅ Focus Unlocked" "\"$TASK_NAME\" completed after ${MINS} minutes."

exit 0
