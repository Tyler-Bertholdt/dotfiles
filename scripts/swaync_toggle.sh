#!/bin/bash

STATE_FILE="/tmp/swaync_state"

# Read current state
if [[ -f "$STATE_FILE" ]]; then
    STATE=$(cat "$STATE_FILE")
else
    STATE="off"
fi

# Toggle swaync and update state
if [[ "$STATE" == "off" ]]; then
    swaync-client -t
    echo "on" > "$STATE_FILE"
else
    swaync-client -t
    echo "off" > "$STATE_FILE"
fi
