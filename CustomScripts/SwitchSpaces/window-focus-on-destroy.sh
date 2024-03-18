#!/bin/zsh
isFocused=$(yabai -m query --windows --window | jq -re ".id")
toFocus=$(yabai -m query --windows --space | jq -re '.[] | select((.["is-visible"] == true) and (.["has-focus"] == false)) ."id"' | head -n 1)
if [[ -z "$isFocused" ]]; then # -z >> true if it's null
    yabai -m window --focus $toFocus
fi