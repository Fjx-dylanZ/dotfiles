#!/bin/zsh
a=$(yabai -m query --windows | jq -re '.[] | select((.["is-visible"] == true) and (.["has-focus"] == false)) ."id"' | head -n 1)
echo $a
echo hi
