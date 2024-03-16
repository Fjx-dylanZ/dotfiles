#!/bin/zsh
# toggle actiev border on focused window

windowsFullJson=$(yabai -m query --windows --space)
focusedWindowId=$(yabai -m query --windows --space | jq -re '.[] | select(.["has-focus"] == true) | .id')
focusedWindowHasBorder=$(yabai -m query --windows --window $focusedWindowId | jq -re '.["has-border"]')
# extract window ids from $windowsFullJson
#windows=$(echo ${windowsFullJson} | jq -re '.[] | .id')
# Draw border on focused window
if [[ -z "$focusedWindowId" ]]; then
    echo "No window is focused"
else
    if [[ $focusedWindowHasBorder != "true" ]]; then
        yabai -m window $focusedWindowId --toggle border
    else
        echo "Focused window $focusedWindowId already has border"
    fi
fi

# Remove border from unfocused windows
for window in $(echo ${windowsFullJson} | jq -re '.[] | .id'); do
    #echo "window is $window"
    
    if [[ $window != $focusedWindowId ]]; then
        #if [[ $(echo $windowsFullJson | jq -re '.[] | select(.id == $window) | .["has-border"]') == "true" ]]; then
        if [[ $(echo $windowsFullJson | jq -re --argjson window $window '.[] | select(.id == $window) | .["has-border"]') == true ]]; then
            echo "Removing border from window $window"
            yabai -m window $window --toggle border
        fi
    fi
done

