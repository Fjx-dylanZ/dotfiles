#!/bin/sh
# front_app
front_app=(
    icon.font="sketchybar-app-font:Regular:15.0"
    label.font="SF Pro:SemiBold:13"
    script="$PLUGIN_DIR/front_app.sh"
    padding_left=5
    padding_right=5
)
sketchybar --add item front_app left \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched