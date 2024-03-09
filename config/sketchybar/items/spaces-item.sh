#!/bin/sh

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid="$(($i+1))"
  label="$(yabai -m query --spaces --space $(($i+1)) | jq -r '.label')"
  type="$(yabai -m query --spaces --space $(($i+1)) | jq -r '.type')"
  qty="$(yabai -m query --windows --space $(($i+1)) | jq -r 'length')"

  case $type in
    'bsp') TYPE_ICON=$YABAI_GRID;
    ;;
    'stack') TYPE_ICON=$YABAI_STACK;
    ;;
    'float') TYPE_ICON=$YABAI_FLOAT;
    ;;
    *) TYPE_ICON=''
  esac

  space=(
    space="$sid"
    icon="${label:-$sid}"
    icon.padding_left=10
    icon.padding_right=0
    icon.highlight_color=$MAGENTA
    icon.font="$FONT:Bold:16"
    label="$TYPE_ICON ${qty:=0}"
    label.padding_right=10
    label.padding_left=4
    label.drawing=on
    label.y_offset=4
    label.font="$FONT:Semibold:10"
    label
    padding_left=2
    padding_right=2
    background.color=$ORANGE
    background.corner_radius=5
    background.drawing=off
    background.height=25
    script="$PLUGIN_DIR/update-spaces.sh"
    click_script="yabai -m space --focus $sid"
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid space_windows_change  \
             --subscribe space.$sid space_change \
             --subscribe space.$sid yalayoutchange \
             --subscribe space.$sid yanewlabel
done

spaces=(
  background.color=$MAGENTA
  background.border_color=$BACKGROUND_2
  background.border_width=2
  background.drawing=on
)

separator=(
  icon=􀆊
  icon.font="$FONT:Heavy:16.0"
  padding_left=15
  padding_right=15
  label.drawing=off
  associated_display=active
  icon.color=$ICON_COLOR
  # click_script='yabai -m space --create && sketchybar --trigger space_change'
)

sketchybar --add bracket spaces '/space\..*/' \
           --set spaces "${spaces[@]}"        \
                                              \
           --add item separator left          \
           --set separator "${separator[@]}"  \