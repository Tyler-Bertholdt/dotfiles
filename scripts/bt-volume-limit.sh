#!/usr/bin/env bash
DEVICE_NAME="Snapods GE3NZ"
TARGET_VOL="0.15"

# Retry a few times in case sink hasn't appeared yet
for i in {1..10}; do
    # Get the numeric Node ID of the sink
    SINK_NODE=$(wpctl status 2>/dev/null | awk -v name="$DEVICE_NAME" '
        /^Sinks:/ {in_sinks=1; next}
        /^├─/ && in_sinks {in_sinks=0}
        in_sinks && index($0,name) {
            for(i=1;i<=NF;i++) if($i ~ /^[0-9]+$/){print $i; exit}
        }
    ')

    if [ -n "$SINK_NODE" ]; then
        wpctl set-volume "$SINK_NODE" "$TARGET_VOL" 2>/dev/null
        echo "Volume set to 15% for $DEVICE_NAME (Sink $SINK_NODE)"
        exit 0
    fi

    sleep 0.5
done

echo "Sink not found. Connect your earbuds first."
exit 0
