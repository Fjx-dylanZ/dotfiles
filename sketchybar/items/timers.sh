#!/bin/bash

sketchybar --add item timer_1 right                      \
           --set timer_1 icon.color=0xff8CB9BD             \
                         icon.font="Font Awesome 6 Free" \
                         icon=􀐫                          \
                         label.color=0xff8CB9BD            \
                         update_freq=1                   \
                         script="$PLUGIN_DIR/timers.sh 1"  \
                         click_script="$PLUGIN_DIR/timers.sh 1 click"

sketchybar --add item timer_2 right                      \
           --set timer_2 icon.color=0xffF99417             \
                         icon.font="Font Awesome 6 Free" \
                         icon=􀐫                          \
                         label.color=0xffF99417            \
                         update_freq=1                   \
                         script="$PLUGIN_DIR/timers.sh 2"  \
                         click_script="$PLUGIN_DIR/timers.sh 2 click"

sketchybar --add item timer_3 right                      \
           --set timer_3 icon.color=0xff99B080             \
                         icon.font="Font Awesome 6 Free" \
                         icon=􀐫                          \
                         label.color=0xff99B080            \
                         update_freq=1                   \
                         script="$PLUGIN_DIR/timers.sh 3"  \
                         click_script="$PLUGIN_DIR/timers.sh 3 click"