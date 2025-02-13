#!/bin/sh

source $HOME/.config/yabai/user/yabai-query.zsh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

if [ "$SENDER" = "front_app_switched" ]; then
  wid=$(ya_query --windows --window | jq '.id')
  prev=$(ya_query --windows --window recent | jq '.id')
  pid_chain="(${wid:-none}) → (${prev:-none})"

  sketchybar --set "$NAME" label="$INFO"
fi
