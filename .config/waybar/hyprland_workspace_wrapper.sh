#!/bin/bash

WORKSPACE_SCRIPT="$HOME/.config/waybar/hyprland_workspace.sh"

HYPRLAND_SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket.sock"

run_script() {
    "$WORKSPACE_SCRIPT"
}

# hyprctl --batch 'subscribeevents workspace' | while read -r event; do
#     run_script
# done

while true; do
    run_script
    sleep 0.05
done
