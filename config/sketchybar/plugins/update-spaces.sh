#!/bin/sh

source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/colors.sh"

# Update space's window count
if [[ "$SENDER" == 'space_change' ]]; then
	sketchybar --set "$NAME" background.drawing="$SELECTED"
	exit 0
fi

# Update space's window count
if [[ "$SENDER" == 'space_windows_change' ]]; then
	sid=${NAME//space\./}
	space="$(yabai -m query --spaces --space $((sid)))"
	label="$(echo $space | jq -r '.label')"
	type="$(echo $space | jq -r '.type')"
	qty="$(yabai -m query --windows --space $((sid)) | jq -r 'length')"

	case ${YA_LAYOUT:-$type} in
		'bsp') icon=$YABAI_GRID;
		;;
		'stack') icon=$YABAI_STACK;
		;;
		'float') icon=$YABAI_FLOAT;
		;;
		*) icon=''
	esac

	sketchybar --set "$NAME" label="$icon $qty"
	exit 0
fi

# Update space's layout icon
if [[ "$SENDER" == 'yalayoutchange' ]]; then
	qty="$(yabai -m query --windows --space $((YA_SPACE_ID)) | jq -r 'length')"

	case ${YA_LAYOUT} in
		'bsp') icon=$YABAI_GRID;
		;;
		'stack') icon=$YABAI_STACK;
		;;
		'float') icon=$YABAI_FLOAT;
		;;
		*) icon=''
	esac

	sketchybar --set "space.$YA_SPACE_ID" label="$icon $qty"
	exit 0
fi

# Update space's name (icon)
if [[ "$SENDER" == 'yanewlabel' ]]; then
	sketchybar --set "space.$YA_SPACE_ID" icon="$YA_LABEL"
fi
