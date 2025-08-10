#!/bin/zsh
killall waybar
killall nwg-dock-hyprland
waybar &disown 
nwg-dock-hyprland -w 5 -p bottom -mb 12 -lp start -l top -i 40 -ico ~/Server/manjaro-vector-logo-seeklogo/manjaro-seeklogo.png -c 'nwg-drawer -mb 80 -ml 100 -mt 80 -mr 100 -ovl -is 50 -closebtn right -spacing 10 -c 6' & disown

 

