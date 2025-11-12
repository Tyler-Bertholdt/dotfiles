#!/bin/bash

# Extract the window title cleanly
title=$(hyprctl activewindow | grep 'title:' | awk -F'title: ' '{print $2}' | sed 's/^"//;s/"$//')

# Fallback if no title found
if [ -z "$title" ]; then
    echo "Arch Linux"
else
    # Truncate to 8 characters + ellipsis if needed
    if [ ${#title} -gt 8 ]; then
        echo "${title:0:8}"
    else
        echo "$title"
    fi
fi
