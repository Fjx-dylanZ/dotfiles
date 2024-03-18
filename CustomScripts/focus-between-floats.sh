#!/bin/bash

# Store the list of floating window IDs into an array and sorted descending
floating_windows=($(yabai -m query --windows --space | jq '.[] | select(.["is-floating"] == true) | .id' | sort -r))
# Get the ID of the currently focused window
focused_window=$(yabai -m query --windows --space | jq -re '.[] | select(.["has-focus"] == true) | .id')

# Check if the currently focused window is in the list of floating windows
found_focused_window=false
for i in "${!floating_windows[@]}"; do
    if [[ "${floating_windows[$i]}" = "${focused_window}" ]]; then
        found_focused_window=true
        next_index=$((i+1))
        if [[ "${next_index}" -lt "${#floating_windows[@]}" ]]; then
            #terminal-notifier -message "Focused next floating window with ID ${floating_windows[${next_index}]}"
            yabai -m window --focus "${floating_windows[${next_index}]}"
        else
            # If there isn't a window with a larger ID, focus the window with the smallest ID
            yabai -m window --focus "${floating_windows[0]}"
        fi
        exit 0
    fi
done

# If the currently focused window is not a floating window and 
# there is at least one floating window, focus the first floating window
if [[ "$found_focused_window" = false ]] && [[ ! -z "${floating_windows[0]}" ]]; then
    yabai -m window --focus "${floating_windows[0]}"
    #terminal-notifier -message "Focused first floating window"
fi