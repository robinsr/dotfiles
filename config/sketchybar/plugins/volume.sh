#!/bin/sh

source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/colors.sh"

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  case "$VOLUME" in
    [6-9][0-9]|100) ICON=$VOLUME_100; COLOR=$RED
    ;;
    [3-5][0-9]) ICON=$VOLUME_66; COLOR=$ORANGE
    ;;
    [1-9]|[1-2][0-9]) ICON=$VOLUME_33; COLOR=$ICON_COLOR
    ;;
    *) ICON=$VOLUME_0 COLOR=$RED;
  esac

  sketchybar --set "$NAME" icon="$ICON" icon.color=$COLOR
fi
