#!/bin/bash

hyprctl dispatch centerwindow
hyprctl dispatch resizeactive exact 1345 750
pkill -SIGUSR1 waybar

dock_pid=$(pidof nwg-dock-hyprland)

if [[ -n "$dock_pid" ]]; then
    kill "$dock_pid"
else
nwg-dock-hyprland -w 5 -p bottom -mb 12 -lp start -l top -i 40 -ico ~/File_Save/manjaro-vector-logo-seeklogo/manjaro-seeklogo.png -c 'nwg-drawer -mb 80 -ml 100 -mt 80 -mr 100 -ovl -is 50 -closebtn right -spacing 10 -c 6' & disown 
fi
