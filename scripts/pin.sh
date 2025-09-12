
#!/bin/bash

dock_pids=$(pgrep -f "nwg-dock-hyprland")

if [[ -n "$dock_pids" ]]; then
    for pid in $dock_pids; do
        kill "$pid"
        sleep 0.1  
    done
fi

nwg-dock-hyprland -d -hd 0 -hl overlay -w 5 -p bottom -mb 7 -lp start -l overlay -i 56 -ico ~/File_Save/manjaro-vector-logo-seeklogo/manjaro-seeklogo.png -c 'nwg-drawer -mb 0 -ml 0 -mt 0 -mr 0 -ovl -is 58 -closebtn none -spacing 30 -c 7 -nocats' & disown

