#!/bin/zsh
killall waybar
killall nwg-dock-hyprland
waybar & disown 
nwg-dock-hyprland -w 5 -p bottom -mb 7 -lp start -l overlay -i 56 -ico ~/File_Save/manjaro-vector-logo-seeklogo/manjaro-seeklogo.png -c 'nwg-drawer -mb 0 -ml 0 -mt 0 -mr 0 -ovl -is 58 -closebtn none -spacing 30 -c 7 -nocats' & disown 

 

