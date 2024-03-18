#!/usr/bin/env bash

# Get the list of floating windows in the current space
floating_windows=($(yabai -m query --windows --space | jq '.[] | select(.["is-floating"] == true) | .id'))

# Check if there are any floating windows
if [ ${#floating_windows[@]} -eq 0 ]; then
  echo "No floating windows found in the current space. Exiting."
  exit 0
fi

# Check if all floating windows are minimized
all_minimized=true
for window in "${floating_windows[@]}"; do
  minimized=$(yabai -m query --windows --window $window | jq '."is-minimized"')
  if [ "$minimized" = "false" ]; then
    all_minimized=false
    break
  fi
done

# If all floating windows are minimized, deminimize them
if [ "$all_minimized" = true ]; then
  for window in "${floating_windows[@]}"; do
    yabai -m window --deminimize $window
  done
  echo "Deminimized all floating windows in the current space."
else
  # Otherwise, minimize all floating windows
  for window in "${floating_windows[@]}"; do
    yabai -m window --minimize $window
  done
  echo "Minimized all floating windows in the current space."
fi