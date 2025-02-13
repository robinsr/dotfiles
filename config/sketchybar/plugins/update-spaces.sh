#!/usr/bin/env zsh

source $HOME/.config/sketchybar/icons.sh
source $HOME/.config/sketchybar/colors.sh
source $HOME/.config/yabai/user/yabai-query.zsh

echo "$$; update-spaces - (#$SENDER.$NAME) - selected: \"$SELECTED\"; info: $(echo $INFO | jq -c .)"

function get_layout_icon {
  case $1 in
    'bsp') echo $GIT_INDICATOR;
    ;;
    'stack') echo $GIT_INDICATOR;
    ;;
    'float') echo $GIT_INDICATOR;
    ;;
    *) echo ''
  esac
}

# Update space's window count
if [[ "$SENDER" == 'space_change' ]]; then
  echo "$$;  - space_change: setting background of \"$NAME\" to \"$SELECTED\""
	sketchybar --set "$NAME" background.drawing="$SELECTED"
	exit 0
fi

# Update space's window count
if [[ "$SENDER" == 'space_windows_change' && "$NAME" == 'spaces' ]]; then
  # Extract the affected space id and the number of windows from $INFO
	sid=$(echo $INFO | jq '.space')
	qty="$(echo $INFO | jq '.apps|to_entries|reduce .[].value as $i (0; . + $i) ')"

	# Query yabai for the space's configuration; extracting the label and type
	ya_query="$(ya_query_cache --spaces --space $sid)"
	label="$(echo $ya_query | jq -r '.label')"
	type="$(echo $ya_query | jq -r '.type')"
	icon="$(get_layout_icon $type)"
	label="$icon $qty"

	echo "$$;  - space_windows_change: setting 'label' of \"space.$sid\" to \"$label\""

	sketchybar --set "space.$sid" label="$label"
	exit 0
fi


function handle_window_count_change {
  space=$1
  qty=$(ya_query_cache --windows --space $space | jq -r 'length')
  layout=$(ya_get_layout $space)
  icon="$(get_layout_icon $layout)"
  label="$icon $qty"

  echo "$$;  - $SENDER: setting 'label' of \"space.$space\" to \"$label\""

  sketchybar --set "space.$space" label="$label"
}

if [[ "$SENDER" == 'ya_window_create' ]]; then
  window=$(echo $INFO | jq -r '.window')
  space=$(ya_query_cache --windows --window $window | jq -r '.space')
  handle_window_count_change $space
  exit 0
fi

if [[ "$SENDER" == 'ya_window_destroy' ]]; then
  # Use the currently active space on window destroy (since the window is no longer available to query)
  space=$(ya_get_active 'space-num')
  handle_window_count_change $space
  exit 0
fi

if [[ "$SENDER" == 'ya_window_moved' ]]; then
  # Use the currently active space, and the recently active space on window moved
  handle_window_count_change $(ya_get_active 'space-num')
  handle_window_count_change $(ya_get_active 'recent-space-num')
  exit 0
fi
