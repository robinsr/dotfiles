#!/usr/bin/env zsh


# Intended to be invoked with arguments (not intended to be sourced)
EVT=$1
if [[ -z $EVT ]]; then
  echo "Usage: $0 <event-name> args"
  exit 1
fi

source $HOME/.config/yabai/user/log.zsh
source $HOME/.config/yabai/user/yabai-query.zsh
source $HOME/.config/yabai/user/yabai-config.zsh

# Needed for logger to get logger
function log {
  __ya_log "#on_display_changed"
}

function on_display_changed {
  __ya_log "#on_display_changed"

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
  __ya_log "#display_added"
  on_display_changed
  open -g "hammerspoon://display.added?id=$YABAI_DISPLAY_ID&index=$YABAI_DISPLAY_INDEX"
fi

if [[ $EVT == 'display_removed' ]]; then
  __ya_log "#display_removed"
  open -g "hammerspoon://display.removed?id=$YABAI_DISPLAY_ID"
fi

if [[ $EVT == 'display_changed' ]]; then
  __ya_log "#display_changed"
  open -g "hammerspoon://display.changed?id=$YABAI_DISPLAY_ID&index=$YABAI_DISPLAY_INDEX&prev_id=$YABAI_RECENT_DISPLAY_ID&prev_index=$YABAI_RECENT_DISPLAY_INDEX"
fi

if [[ $EVT == 'window_created' ]]; then
  __ya_log "#window_created $YABAI_WINDOW_ID"
fi

if [[ $EVT == 'window_destroyed' ]]; then
  __ya_log "#window_destroyed $YABAI_WINDOW_ID"
fi

if [[ $EVT == 'window_moved' ]]; then
  __ya_log "#window_moved $YABAI_WINDOW_ID"
fi

if [[ $EVT == 'space_created' ]]; then
    __ya_log "#space_created $YABAI_WINDOW_ID"
    open -g "hammerspoon://spaces.created?id=$YABAI_SPACE_ID&index=$YABAI_SPACE_INDEX"
fi

if [[ $EVT == 'space_destroyed' ]]; then
    __ya_log "#space_destroyed $YABAI_WINDOW_ID"
    open -g "hammerspoon://spaces.destroyed?id=$YABAI_SPACE_ID"
fi

if [[ $EVT == 'space_changed' ]]; then
  __ya_log "#space_changed $YABAI_WINDOW_ID"

  local params="to=$YABAI_SPACE_INDEX&from=$YABAI_RECENT_SPACE_INDEX"
  
  open -g "hammerspoon://spaces.changed?$params"
fi
