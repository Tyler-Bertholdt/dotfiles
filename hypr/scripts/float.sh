#!/bin/bash

hyprctl dispatch centerwindow
hyprctl dispatch resizeactive exact 1345 750
pkill -SIGUSR1 waybar

# This assumes Waybar is configured to toggle on SIGUSR1

