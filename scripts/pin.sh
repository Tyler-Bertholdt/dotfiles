#!/bin/bash

# Check if nwg-dock-hyprland is running
if pgrep -x "nwg-dock-hyprland" > /dev/null; then
    # Send SIGUSR1 to toggle visibility
    pkill -USR1 -x "nwg-dock-hyprland"
else
    # Start nwg-dock-hyprland with autohide enabled
    nwg-dock-hyprland -d &
fi
