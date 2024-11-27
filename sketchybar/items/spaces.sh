#!/bin/sh
##### Adding Mission Control Space Indicators #####
# Let's add some mission control spaces:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item
# to indicate active and available mission control spaces.

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")
for i in "${!SPACE_ICONS[@]}"
do
  sid="$(($i+1))"
  space=(
    space="$sid"
    icon="${SPACE_ICONS[i]}"
    icon.padding_left=5
    icon.padding_right=5
    background.color=0x40ffffff
    background.corner_radius=10
    background.height=20
    label.font="sketchybar-app-font:Regular:15.0"
    label.padding_right=15
    label.y_offset=-2
    script="$PLUGIN_DIR/space.sh"
    click_script="yabai -m space --focus $sid"
  )
  sketchybar --add space space."$sid" left --set space."$sid" "${space[@]}"
done

sketchybar --add item chevron left \
           --set chevron icon="􀆊" label.drawing=off \
           --set chevron script="$PLUGIN_DIR/space_windows.sh" \
           --subscribe chevron window_change_yabai space_windows_change

