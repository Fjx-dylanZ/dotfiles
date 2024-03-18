#!/usr/bin/env bash

read -r id floating <<< $(echo $(yabai -m query --windows --window | jq '.id, .["is-floating"]'))
tmpfile=/tmp/yabai-floating-toggle-center/$id

if [ $floating = 'true' ]
then
  if [ -e $tmpfile ]
  then
    read -r x y w h <<< $(echo $(cat $tmpfile | jq '.x, .y, .w, .h'))
    yabai -m window --move abs:$x:$y
    yabai -m window --resize abs:$w:$h
    rm $tmpfile
  else
    echo $(yabai -m query --windows --window | jq .frame) >> $tmpfile
    yabai -m window --grid 5:5:1:1:3:3
  fi
else
  echo "The focused window is not floating. Exiting."
  exit 1
fi