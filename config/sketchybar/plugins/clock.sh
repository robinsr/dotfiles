#!/bin/sh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

TIME=$(date '+%-I:%M %p')
DATE=$(date '+%a, %b %-d')
DAY=$(date '+%-d')

case ${DAY} in
  1|21|31) ORDINAL='st'
  ;;
  2|22) ORDINAL='nd'
  ;;
  3|23) ORDINAL='rd'
  ;;
  *) ORDINAL='th'
esac

sketchybar --set "$NAME" label="$DATE$ORDINAL ⎪ $TIME"

