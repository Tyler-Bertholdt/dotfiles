#!/bin/bash

dock_pid=$(pidof nwg-dock-hyprland)

if [[ -n "$dock_pid" ]]; then
    kill "$dock_pid"
else
nwg-dock-hyprland -w 5 -p bottom -mb 12 -lp start -l top -i 40 -ico ~/Server/manjaro-vector-logo-seeklogo/manjaro-seeklogo.png & disown
fi
