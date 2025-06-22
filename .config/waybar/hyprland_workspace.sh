#!/bin/bash

# MONITOR_NAME=HDMI-A-1
MONITOR_NAME="${WAYBAR_OUTPUT_NAME:-DP-1}"

WORKSPACES_JSON=$(hyprctl workspaces -j)

ACTIVE_WORKSPACE_ID=$(hyprctl activeworkspace -j | jq -r '.id')

OUTPUT_TEXT=""

for id in $(echo "$WORKSPACES_JSON" | jq -r --arg m "$MONITOR_NAME" '.[] | select(.monitor == $m) | .id' | sort -n); do
    if (( id > 10 )); then
        mod_id=$((id - 10))
    else
        mod_id=$id
    fi
    if (( id == $ACTIVE_WORKSPACE_ID )); then
        # OUTPUT_TEXT+="\e[4m$id\e[24m "
        OUTPUT_TEXT+="[$mod_id] "
    else
        OUTPUT_TEXT+="$mod_id "
    fi
done

echo -e $OUTPUT_TEXT | xargs

