#!/bin/zsh
killall swaync
swaync & disown
swaync-client -t
 

