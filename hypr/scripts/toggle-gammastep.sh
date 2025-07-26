#!/bin/bash

STATE_FILE="$HOME/.cache/color_temp_state"
MIN_TEMP=3500
MAX_TEMP=6500
STEP=250

# Init if missing
if [[ ! -f "$STATE_FILE" ]]; then
    echo "$MAX_TEMP" > "$STATE_FILE"
fi

CUR_TEMP=$(cat "$STATE_FILE")

if [[ "$1" == "down" ]]; then
    NEW_TEMP=$((CUR_TEMP - STEP))
    [[ $NEW_TEMP -lt $MIN_TEMP ]] && NEW_TEMP=$MIN_TEMP
elif [[ "$1" == "up" ]]; then
    NEW_TEMP=$((CUR_TEMP + STEP))
    [[ $NEW_TEMP -gt $MAX_TEMP ]] && NEW_TEMP=$MAX_TEMP
else
    exit 1
fi

gammastep -O "$NEW_TEMP"
echo "$NEW_TEMP" > "$STATE_FILE"
