#!/bin/zsh
# query window every 0.1s and log the result

# log file
logFile="/Users/fanjiaxz/CustomScripts/SwitchSpaces/window.log"
if [[ -f $logFile ]]; then
    rm $logFile
fi

# query window every 0.1s and log the result
while true; do
    yabai -m query --windows --window >> $logFile
    sleep 0.05
done
