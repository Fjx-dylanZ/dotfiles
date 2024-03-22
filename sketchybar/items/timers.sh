#!/bin/bash
TIMER_FILE="/tmp/sketchybar_timers.json"
PLUGIN_DIR="$HOME/.config/sketchybar/plugins"
# Add a dynamic timer creation function
add_timer() {
    local timer_id="timer_$1"
    local color=$2
    sketchybar --add item $timer_id right                      \
               --set $timer_id icon.color=$color             \
                             icon.font="Font Awesome 6 Free" \
                             icon=􀐫                          \
                             label.color=$color            \
                             update_freq=1                   \
                             script="$PLUGIN_DIR/timers.sh $1"  \
                             click_script="$PLUGIN_DIR/timers.sh $1 click" \
               --move $timer_id before timer_add
}
case "$#" in
  0)
    sketchybar --add item timer_add right                      \
               --set timer_add icon.drawing=off                         \
                         label="+"                         \
                         label.y_offset=1                \
                         background.color=0x30ffffff            \
                         background.height=22            \
                         background.corner_radius=10  \
                         click_script="$PLUGIN_DIR/timers.sh add"

    # Initial Timers Creation (can be modified to create initial set of timers)
    add_timer 1 0xff8CB9BD
    add_timer 2 0xffF99417
    add_timer 3 0xff99B080
    if [ ! -f "$TIMER_FILE" ]; then
        echo '{"timer_1": {"end_time": null, "duration": 10800, "remaining": null}, "timer_2": {"end_time": null, "duration": 3600, "remaining": null}, "timer_3": {"end_time": null, "duration": 3600, "remaining": null}}' > "$TIMER_FILE"
    fi
    ;;
  *)
    # if first arguemnt is add_timer
    if [ "$1" = "add_timer" ]; then
        add_timer "$2" "$3"
    fi
    ;;
esac

# if [ $# -eq 0 ]; then
#     sketchybar --add item timer_add right                      \
#                --set timer_add icon=􀍨                         \
#                          label="+"                         \
#                          click_script="$PLUGIN_DIR/timers.sh add"

#     # Initial Timers Creation (can be modified to create initial set of timers)
#     add_timer 1 0xff8CB9BD
#     add_timer 2 0xffF99417
#     add_timer 3 0xff99B080
#     if [ ! -f "$TIMER_FILE" ]; then
#         echo '{"timer_1": {"end_time": null, "duration": 10800, "remaining": null}, "timer_2": {"end_time": null, "duration": 3600, "remaining": null}, "timer_3": {"end_time": null, "duration": 3600, "remaining": null}}' > "$TIMER_FILE"
#     fi
# fi
