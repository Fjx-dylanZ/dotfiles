#!/bin/bash
TIMER_FILE="/tmp/sketchybar_timers.json"
PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

refresh_bracket() {
    local barItems_json=$(sketchybar --query bar)
    # check if timers_bracket already exists
    if echo $barItems_json | jq -e '.items[]' | grep -q "timers_bracket"; then
        echo "Removing existing timers_bracket"
        sketchybar --remove timers_bracket
    fi
    sketchybar --add bracket timers_bracket '/timer_.*/'  \
               --set timers_bracket background.color=0x306C5F5B \
                                            background.corner_radius=20  \
                                            background.height=25 \
                                            blur_radius=8
}

add_timer() {
    local timer_id="timer_$1"
    local color=$2
    local duration=$3
    sketchybar --add item $timer_id right \
        --set $timer_id icon.color=$color \
                        icon.font="Font Awesome 6 Free" \
                        icon=􀐫 \
                        label.color=$color \
                        update_freq=1 \
                        script="$PLUGIN_DIR/timers.sh $1" \
                        click_script="$PLUGIN_DIR/timers.sh $1 click" \
        --move $timer_id before timer_add
    refresh_bracket
}

case "$#" in
    0)
        sketchybar --add item timer_add right \
            --set timer_add icon.drawing=off \
                            label="+" \
                            label.y_offset=1 \
                            background.color=0x30ffffff \
                            background.height=22 \
                            background.corner_radius=10 \
                            click_script="$PLUGIN_DIR/timers.sh add"
        refresh_bracket
        if [ -f "$TIMER_FILE" ]; then
            jq -c 'keys[]' "$TIMER_FILE" | while read -r timer_key; do
                timer_id=$(echo $timer_key | sed 's/^"\(.*\)"$/\1/')
                color=$(jq -r ".[$timer_key].color" "$TIMER_FILE")
                duration=$(jq -r ".[$timer_key].duration" "$TIMER_FILE")
                echo "Adding timer $timer_id with color $color and duration $duration"
                add_timer "${timer_id#timer_}" "$color" "$duration"
            done
        fi
        ;;
    *)
        if [ "$1" = "add_timer" ]; then
            add_timer "$2" "$3" "$4"
        fi
        ;;
esac