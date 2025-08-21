#!/bin/bash

if hyprctl layers | grep -q "swaync-control-center"; then
    echo ""   # ON icon
else
    echo ""   # OFF icon
fi
