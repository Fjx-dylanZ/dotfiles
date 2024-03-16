#!/bin/zsh
# toggle bsp/floating layout

## get current space layout
currentSpaceLayout=$(yabai -m query --spaces --space | jq -re ".type")

if [[ $currentSpaceLayout == "bsp" ]]; then
    yabai -m space --layout float
else
    yabai -m space --layout bsp
fi