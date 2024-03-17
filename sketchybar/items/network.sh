#!/bin/sh
sketchybar -m --add       item               network_up right                                               \
              --set       network_up         label.font="SF Pro:Heavy:9"                                   \
                                             icon.drawing=off                                               \
                                             y_offset=5                                                    \
                                             width=0                                                       \
                                             update_freq=2                                                 \
                                             script="~/.config/sketchybar/plugins/network.sh"              \
                                                                                                           \
              --add       item               network_down right                                             \
              --set       network_down       label.font="SF Pro:Heavy:9"                                   \
                                             icon.drwain=off                                                \
                                             y_offset=-5