#!/usr/bin/env zsh

export YABAI_BAR_TOP=0
export YABAI_BAR_BOTTOM=30


ya_set_config () {
  yabai -m config "$@"
}

ya_toggle_bar () {
  ya -m config external_bar all:$YABAI_BAR_TOP:$YABAI_BAR_BOTTOM
}

ya_set_label () {
  yabai -m space $1 --label $2

  if [[ -n "${commands[sketchybar]}" ]]; then
    sketchybar --trigger yanewlabel YA_SPACE_ID=$1 YA_LABEL=$2
  fi
}
