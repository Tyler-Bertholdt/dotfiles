#!/bin/zsh
killall waybar
killall nwg-dock-hyprland
waybar &disown 
nwg-dock-hyprland -w 5 -p bottom -mb 12 -lp start -l top -i 40 -ico ~/Server/manjaro-vector-logo-seeklogo/manjaro-seeklogo.png & disown
n
 

