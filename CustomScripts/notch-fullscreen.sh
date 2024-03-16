#!bin/zsh
#conda activate base
#echo $(which python) > ~/.config/CustomScripts/frida.log
is_floating="$(yabai -m query --windows --window | jq -re '.["is-floating"]')"
is_sticky="$(yabai -m query --windows --window | jq -re '.["is-sticky"]')"
#terminal-notifier -message "is_floating: $is_floating, is_sticky: $is_sticky"
if [ "$is_floating" = "true" ]; then
  if [ "$is_sticky" = "true" ]; then
    yabai -m window --toggle sticky
    app_process=$(osascript -e 'tell application "System Events" to get unix id of first application process whose frontmost is true')
    if [ $? -eq 0 ]; then
      frida -q -l ~/.config/CustomScripts/OverNotch.js -e "toggleFullScreen()" $app_process > ~/.config/CustomScripts/frida.log 2>&1
    else
      echo "osascript command failed"
      exit 1
    fi
  else
    app_process=$(osascript -e 'tell application "System Events" to get unix id of first application process whose frontmost is true')
    if [ $? -eq 0 ]; then
      #frida -q -l ~/.config/CustomScripts/OverNotch.js -e "toggleFullScreen()" $app_process > ~/.config/CustomScripts/frida.log 2>&1
      frida_output=$(frida -q -l ~/.config/CustomScripts/OverNotch.js -e "toggleFullScreen()" $app_process 2>&1)
      #terminal-notifier -message "frida_output: $frida_output"
      frida_output_trimmed=$(echo $frida_output | xargs)
      if [[ $frida_output_trimmed == "STOP" ]]; then
        echo "stop" > ~/.config/CustomScripts/frida.log
        yabai -m window --toggle float
      fi
    else
      echo "osascript command failed"
      exit 1
    fi
  fi
else
  yabai -m window --toggle float
  app_process=$(osascript -e 'tell application "System Events" to get unix id of first application process whose frontmost is true')
  #terminal-notifier -message "app_process: $app_process"
  if [ $? -eq 0 ]; then
    frida -q -l ~/.config/CustomScripts/OverNotch.js -e "toggleFullScreen()" $app_process > ~/.config/CustomScripts/frida.log 2>&1
  else
    echo "osascript command failed"
    exit 1
  fi
fi