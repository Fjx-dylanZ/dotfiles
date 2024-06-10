#!/bin/bash

TIMER_FILE="/tmp/sketchybar_timers.json"
ITEMS_DIR="$HOME/.config/sketchybar/items"
# initialize_timers() {
#   if [ ! -f "$TIMER_FILE" ]; then
#     echo '{"timer_1": {"end_time": null, "duration": 10800, "remaining": null}, "timer_2": {"end_time": null, "duration": 3600, "remaining": null}, "timer_3": {"end_time": null, "duration": 3600, "remaining": null}}' > "$TIMER_FILE"
#   fi
# }
initialize_timers() {
    if [ ! -f "$TIMER_FILE" ]; then
        echo '{}' > "$TIMER_FILE"
    fi
}

add_new_timer() {
    local new_timer_id=$(($(jq 'keys | length' "$TIMER_FILE") + 1))
    local new_timer_key="timer_$new_timer_id"
    local color="0xffF94A1E"  # Default color, you can change this or make it configurable
    local duration=3600  # Default duration, you can change this or make it configurable
    jq ". + {\"$new_timer_key\": {\"end_time\": null, \"duration\": $duration, \"remaining\": null, \"color\": \"$color\"}}" "$TIMER_FILE" > "$TIMER_FILE.tmp" && mv "$TIMER_FILE.tmp" "$TIMER_FILE"
    "$ITEMS_DIR/timers.sh" add_timer $new_timer_id "$color" "$duration"
}

get_end_time() {
  jq -r ".timer_$1.end_time" "$TIMER_FILE"
}

get_duration() {
  jq -r ".timer_$1.duration" "$TIMER_FILE"
}

get_remaining() {
  jq -r ".timer_$1.remaining" "$TIMER_FILE"
}

set_end_time() {
  jq ".timer_$1.end_time = $2" "$TIMER_FILE" > "$TIMER_FILE.tmp" && mv "$TIMER_FILE.tmp" "$TIMER_FILE"
}

set_remaining() {
  jq ".timer_$1.remaining = $2" "$TIMER_FILE" > "$TIMER_FILE.tmp" && mv "$TIMER_FILE.tmp" "$TIMER_FILE"
}

format_time() {
  remaining=$1
  hours=$((remaining / 3600))
  minutes=$((remaining % 3600 / 60))
  seconds=$((remaining % 60))
  printf "%02d:%02d:%02d" $hours $minutes $seconds
}
ensure_order() {
  json=$(cat "$TIMER_FILE")

  # Extract the timer keys and sort them
  timer_keys=$(echo "$json" | jq -r 'keys[]' | sort)

  # Check if the timer keys are in the expected order
  expected_keys=$(seq 1 $(echo "$timer_keys" | wc -l) | sed 's/^/timer_/')

  if [ "$timer_keys" != "$expected_keys" ]; then
    # Reorder the timer keys
    reordered_json=$(echo "$json" | jq 'to_entries | sort_by(.key) | to_entries | map({key: ("timer_" + ((.key | tostring) + 1)), value: .value}) | from_entries')
    echo "$reordered_json" > "$TIMER_FILE"
  fi
    # destroy all timers and re-add them in order
    #sketchybar --remove "/timer*/"
    #"$ITEMS_DIR/timers.sh"
}
# handle popup $SENDER==mouse.entered or mouse.exited
case "$SENDER" in
  "mouse.entered")
    sketchybar --set timer_$1 popup.drawing=on
    ;;
  "mouse.exited")
    sketchybar --set timer_$1 popup.drawing=off
    ;;
esac

case "$1" in
  "add")
    initialize_timers 
    add_new_timer
    ;;
  [0-9]*) 
    end_time=$(get_end_time "$1")
    duration=$(get_duration "$1")
    remaining=$(get_remaining "$1")

    if [ "$2" = "click" ]; then
      if [ "$BUTTON" = "left" ]; then
        if [ "$end_time" != "null" ]; then
          # Pause the timer
          current_time=$(date +%s)
          remaining=$((end_time - current_time))
          set_end_time "$1" "null"
          set_remaining "$1" "$remaining"
          sketchybar --set timer_$1 label=$(format_time $remaining)
        else
          # Resume the timer
          if [ "$remaining" != "null" ]; then
            set_end_time "$1" $(($(date +%s) + remaining))
            set_remaining "$1" "null"
          else
            # Start the timer
            set_end_time "$1" $(($(date +%s) + duration))
          fi
        fi
      elif [ "$BUTTON" = "right" ]; then
        # Reset the timer
        set_end_time "$1" "null"
        set_remaining "$1" "null"
        sketchybar --set timer_$1 label="00:00:00"
      fi
    elif [ "$2" = "delete" ]; then
      jq "del(.timer_$1)" "$TIMER_FILE" > "$TIMER_FILE.tmp" && mv "$TIMER_FILE.tmp" "$TIMER_FILE"
      sketchybar --remove timer_$1
      ensure_order
    else
      if [ "$end_time" != "null" ]; then
        current_time=$(date +%s)
        remaining=$((end_time - current_time))
        if [ $remaining -le 0 ]; then
          set_end_time "$1" "null"
          set_remaining "$1" "null"
          sketchybar --set timer_$1 label="00:00:00"
        else
          if [ $((remaining % 300)) -eq 0 ]; then
            sketchybar --animate tanh 15 --set timer_$1 icon.y_offset=-5
            sketchybar --animate tanh 15 --set timer_$1 icon.y_offset=0
          fi
          sketchybar --set timer_$1 label=$(format_time $remaining)
        fi
      else
        if [ "$remaining" != "null" ]; then
          sketchybar --set timer_$1 label=$(format_time $remaining)
        else
          sketchybar --set timer_$1 label="00:00:00"
        fi
      fi
    fi
    ;;
esac