#!/bin/bash

if [ "$SENDER" = "space_windows_change" ]; then
  #echo "space_window_change" > /tmp/window_chang
  space="$(echo "$INFO" | jq -r '.space')"
  apps="$(echo "$INFO" | jq -r '.apps | keys[]')"
  #echo "$space" "$apps" > /tmp/window_chang
elif [ "$SENDER" = "window_change_yabai" ]; then
  #echo "window_change signal received" > /tmp/window_chang
  space="$(yabai -m query --spaces --space | jq -r '.index')"
  apps="$(yabai -m query --windows --space $space | jq -r '.[].app' | uniq)"
  #echo "space: $space" > /tmp/window_chang
  #echo "apps: $apps" > /tmp/window_chang
else
  exit 0
fi

icon_strip=" "
if [ "${apps}" != "" ]; then
  while read -r app
  do
    icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
  done <<< "${apps}"
else
  icon_strip="—"
fi

sketchybar --set space.$space label="$icon_strip"