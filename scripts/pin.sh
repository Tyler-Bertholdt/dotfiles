
#!/bin/bash

CURRENT_LAYER=$(hyprctl activewindow | grep "layer" | awk '{ print $2 }')

if [ "$CURRENT_LAYER" == "overlay" ]; then
    hyprctl dispatch movetolayer default
else
    hyprctl dispatch movetolayer overlay
fi
