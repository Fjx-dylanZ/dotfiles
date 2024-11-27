#!/usr/bin/env bash

TEMP_FILE="/tmp/minimized_windows.txt"

# Get the list of floating windows in the current space
floating_windows=($(yabai -m query --windows --space | jq '.[] | select((.["is-floating"] == true) and (.["is-visible"] == true)) | select(.subrole == "AXStandardWindow") | .id'))

# Check if we have previously minimized windows
if [ -f "$TEMP_FILE" ]; then
    # Check if the file is not older than 1 hour
    if [ $(( $(date +%s) - $(stat -f %m "$TEMP_FILE") )) -lt 3600 ]; then
        while read -r window; do
            if yabai -m query --windows --window "$window" >/dev/null 2>&1; then
                yabai -m window --deminimize "$window"
            fi
        done < "$TEMP_FILE"
        rm "$TEMP_FILE"  # Only remove after successful restoration
        echo "Restored minimized windows."
    else
        rm "$TEMP_FILE"
        echo "Saved window state was too old. Starting fresh."
    fi
else

    # Check if there are any floating windows
    if [ ${#floating_windows[@]} -eq 0 ]; then
        terminal-notifier -message "No floating windows found in the current space. Exiting."
        exit 0
    fi


    # Minimize windows and save their IDs
    for window in "${floating_windows[@]}"; do
        minimized=$(yabai -m query --windows --window $window | jq '."is-minimized"')
        if [ "$minimized" = "false" ]; then
            yabai -m window --minimize "$window"
            echo "$window" >> "$TEMP_FILE"
        fi
    done
    echo "Minimized floating windows and saved their IDs."
fi

