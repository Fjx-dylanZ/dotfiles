#!/bin/zsh
## get pip based on window properties
### -> if window is floating, toggle pip
### -> if window is not floating, toggle floating, then toggle pip
floating=$(yabai -m query --windows --window | jq -re ".is-floating")
if [[ $floating == "true" ]]; then
    yabai -m window --toggle pip
    yabai -m window --toggle float
else
    yabai -m window --toggle float
    yabai -m window --toggle pip
fi
    