#!/bin/bash

case "$1" in
  "1") 
    end_time_file="/tmp/sketchybar_timer_1_end_time"
    duration=1500
    ;;
  "2")
    end_time_file="/tmp/sketchybar_timer_2_end_time"
    duration=1200
    ;;  
  "3")
    end_time_file="/tmp/sketchybar_timer_3_end_time"
    duration=900
    ;;
esac

if [ "$2" = "click" ]; then
  if [ "$BUTTON" = "left" ]; then
    if [ -f "$end_time_file" ]; then
      rm "$end_time_file"
    else
      echo $(($(date +%s) + duration)) > "$end_time_file"
    fi
  elif [ "$BUTTON" = "right" ]; then
    rm "$end_time_file" 2>/dev/null
  fi
else
  if [ -f "$end_time_file" ]; then
    end_time=$(cat "$end_time_file")
    current_time=$(date +%s)
    remaining=$((end_time - current_time))

    if [ $remaining -le 0 ]; then
      rm "$end_time_file"
      sketchybar --set timer_$1 label="00:00"
    else
      minutes=$((remaining / 60))
      seconds=$((remaining % 60))

      if [ $((remaining % 300)) -eq 0 ]; then
        sketchybar --animate tanh 15 --set timer_$1 icon.y_offset=-5
        sketchybar --animate tanh 15 --set timer_$1 icon.y_offset=0
      fi

      sketchybar --set timer_$1 label=$(printf "%02d:%02d" $minutes $seconds)
    fi
  else
    sketchybar --set timer_$1 label="00:00"
  fi
fi