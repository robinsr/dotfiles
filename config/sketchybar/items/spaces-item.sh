#!/bin/sh

source $HOME/.config/yabai/user/yabai-query.zsh

SPACE_ICONS=("")
YA_QUERY=$(ya_query_cache --spaces)
SPACE_COUNT=$(echo $YA_QUERY | jq -r 'length')

# echo "'yabai -m query --spaces': $YA_QUERY"

INDEX=0
while [ $INDEX -lt $((SPACE_COUNT)) ]; do
  SPACE_LABEL=$(echo $YA_QUERY | jq -r ".[$INDEX].label")
  if [ -z "$SPACE_LABEL" ]; then
    SPACE_LABEL="$(($INDEX+1))"
  fi
  SPACE_ICONS[$INDEX]=$SPACE_LABEL
  INDEX=$(($INDEX+1))
done

echo SPACE_ICONS: ${SPACE_ICONS[@]}



sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid="$(($i+1))"
  # label="$(yabai -m query --spaces --space $(($i+1)) | jq -r '.label')"
  # type="$(yabai -m query --spaces --space $(($i+1)) | jq -r '.type')"
  label="${SPACE_ICONS[i]}"
  label="${SPACE_ICONS[@]:$i:1}"
  type="$(echo $YA_QUERY | jq -r ".[$sid].type")"
  qty="$(ya_query_cache --windows --space $(($i+1)) | jq -r 'length')"

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
    icon="$TYPE_ICON ${qty:=0}"
    icon.padding_left=10
    icon.padding_right=0
    icon.highlight_color=$MAGENTA
    icon.font="$FONT:Bold:16"
    label="${label:-$sid}"
    label.padding_right=10
    label.padding_left=4
    label.drawing=on
    label.y_offset=4
    label.font="$FONT:Semibold:10"
    label
    padding_left=2
    padding_right=2
    background.color=$ORANGE_DARK
    background.corner_radius=5
    background.drawing=off
    background.height=25
    click_script="$PLUGIN_DIR/click-space.sh $sid"
    script="$PLUGIN_DIR/update-spaces.sh"
  )

  # A 'space' component already subscribes to space_change event
  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}"
done

spaces_props=(
  background.color=$MAGENTA
  background.border_color=$BACKGROUND_2
  background.border_width=2
  background.drawing=on
  script="$PLUGIN_DIR/update-spaces.sh"
)

sketchybar --add bracket spaces '/space\..*/' \
           --set spaces "${spaces_props[@]}" \
           # --subscribe spaces
           # ya_layout_change ya_new_label ya_window_create ya_window_destroy ya_window_moved
           # space_windows_change

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

sketchybar --add item separator left \
           --set separator "${separator[@]}"
