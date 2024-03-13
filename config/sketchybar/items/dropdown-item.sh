#!/usr/bin/env zsh

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/config.zsh"


add_menu_item () {
	local ITEM_NAME=$1
	local ITEM_POSITION=$2
	local ITEM_PROPS=$3

	sketchybar \
		--add item $ITEM_NAME $ITEM_POSITION \
 		--set $ITEM_NAME $@
}

shrink_script () {
	echo "$@"  #  | sed -En 's/poop/dick/'
}

dropdown_btn_props=(
	icon=$ICON_CLICK
	icon.font="$FONT:Black:16.0"
	label.drawing=off
	click_script="sketchybar -m --set \$NAME popup.drawing=toggle"
	popup.background.border_width=2
	popup.background.corner_radius=3
	popup.background.border_color=$WHITE
	popup.background.color=$TUNA
)

preferences_props=(
	icon=$ICON_COG
	label=Preferences
	click_script=$(shrink_script "open -a 'System Preferences'; 
				sketchybar -m --set dropdown.logo popup.drawing=off")
)

activity_props=(
)

lockscreen_props=(

)



sketchybar \
	--add item dropdown.logo right \
	--set dropdown.logo "${dropdown_btn_props[@]}" \
	--default background.padding_left=5 \
            background.padding_right=5 \
            icon.padding_right=5 \
            icon.font="$FONT:Bold:16.0" \
            label.font="$FONT:Semibold:13.0"

add_menu_item 'apple.preferences' 'popup.dropdown.logo' "${preferences_props[@]}"


sketchybar \
	--add item apple.activity popup.dropdown.logo \
	--set apple.activity icon=$ICON_ACTIVITY \
                   label="Activity" \
                   click_script="open -a 'Activity Monitor'; sketchybar -m --set dropdown.logo popup.drawing=off"

sketchybar \
	--add item apple.lock popup.dropdown.logo \
	--set apple.lock icon=$ICON_LOCK \
           label="Lock Screen" \
           click_script="pmset displaysleepnow; sketchybar -m --set dropdown.logo popup.drawing=off"                           