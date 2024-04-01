#!/usr/bin/env zsh

source $HOME/.config/yabai/user/yabai-query.zsh

EVT=$1

if [[ -z $EVT ]]; then
  echo "Usage: $0 <event-name> args"
  exit 1
fi

source $HOME/.config/yabai/user/yabai-config.zsh

function on_display_changed {
  local LAYOUT=$(ya_suggest layout)
  local PAD_X=$(ya_suggest padding-x)
  local PAD_Y=$(ya_suggest padding-y)
  local WINDOW_GAP=$(ya_suggest gap)

  yabai -m config top_padding $PAD_Y
  yabai -m config bottom_padding $PAD_Y
  yabai -m config left_padding $PAD_X
  yabai -m config right_padding $PAD_X
  yabai -m config window_gap $WINDOW_GAP
  yabai -m config layout $LAYOUT

  yabai -m space $(ya_get_active 'space-num') --layout $LAYOUT
}

if [[ $EVT == 'display_added' ]]; then
  echo "display_added"
  on_display_changed
fi

if [[ $EVT == 'display_removed' ]]; then
  echo "display_removed"
  on_display_changed
fi

if [[ $EVT == 'window_created' ]]; then
  echo "window_created $YABAI_WINDOW_ID"
fi

if [[ $EVT == 'window_destroyed' ]]; then
  echo "window_destroyed $YABAI_WINDOW_ID"
fi

if [[ $EVT == 'window_moved' ]]; then
  echo "window_moved $YABAI_WINDOW_ID"
fi
