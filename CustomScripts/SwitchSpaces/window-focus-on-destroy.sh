#!/bin/zsh
isFocused=$(yabai -m query --windows --window | jq -re ".id")
echo $isFocused
toFocus=$(yabai -m query --windows --space | jq -re '.[] | select((.["is-visible"] == true) and (.["has-focus"] == false)) ."id"' | head -n 1)
if [[ -z "$isFocused" ]]; then # -z >> true if it's null
    echo "No window is focused"
    echo "toFocus is $toFocus"
    yabai -m window --focus $toFocus

fi