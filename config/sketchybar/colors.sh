#!/bin/bash

set_alpha () {
	COLOR=$1
	AMT=$(($2 * 255 / 100))
	HEX="$(echo $COLOR | sed -E 's/^0x[0-9a-f]{2}//')"
	ALPHA=$(printf '%X' $AMT)

	echo "0x$ALPHA$HEX"
}

hex_to_dec () {
	echo $((16#$1))
}

dec_to_hex () {
	printf "%x\n" $1
}


# Naive color darken algorithm.
#
#  $0 - hex color in ARGB format (0xAARRGGBB)
#  $1 - percentage (0-100)
#
# Usage:
# 
# burnt_orance=$(color_darken $ORANGE 75)
# totally_black=$(color_darken $ORANGE 0)
color_darken () {
	COLOR=$1
	PCT=$2

	# echo "color_darken: color: $COLOR; percent: $PCT"

	HEX_A=${COLOR:0:4}
	HEX_R=${COLOR:4:2}
	HEX_G=${COLOR:6:2}
	HEX_B=${COLOR:8:2}

	NEW_R=$(($PCT * 16#$HEX_R / 100))
	NEW_G=$(($PCT * 16#$HEX_G / 100))
	NEW_B=$(($PCT * 16#$HEX_B / 100))

	# echo "$HEX_R -> $((16#$HEX_R)) → $NEW_R -> $(dec_to_hex $NEW_R)"
	# echo "$HEX_G -> $((16#$HEX_G)) → $NEW_G -> $(dec_to_hex $NEW_G)"
	# echo "$HEX_B -> $((16#$HEX_B)) → $NEW_B -> $(dec_to_hex $NEW_B)"

	NEW_ARGB="$HEX_A$(dec_to_hex $NEW_R)$(dec_to_hex $NEW_G)$(dec_to_hex $NEW_B)"
	
	echo $NEW_ARGB
}



# Color Palette
export CLAY=0xa024273a # EbonyClay
export TUNA=0x903c3e4f # Tuna
export RIVER_BED=0x90494d64 # RiverBed
export BLACK=0xff181926 # Mirage
export WHITE=0xfff0f0f0 # Gallery
export MOON=0xffcad3f5 # MoonRaker
export WHITE_40=0x40cad3f5 # MoonRaker(40)
export RED=0xffed8796 # Mauvelous
export GREEN=0xffa6da95 # Feijoa
export BLUE=0xff8aadf4 # JordyBlue
export YELLOW=0xffeed49f # Chalky
export ORANGE=0xfff5a97f # Rajah
export ORANGE_DARK=$(color_darken $ORANGE 60)
export PURPLE1=0xffc6a0f6 # PerfumeA
export PURPLE=0xffd8a0fb # PerfumeB
export GREY=0xff939ab7 # BaliHai
export TRANSPARENT=0x00000000

# General bar colors
export BAR_COLOR=$CLAY
export BORDER_COLOR=$WHITE_40
export BACKGROUND_1=$TUNA
export BACKGROUND_2=$RIVER_BED

export ICON_COLOR=$WHITE
export LABEL_COLOR=$WHITE

export POPUP_BACKGROUND_COLOR=$CLAY
export POPUP_BORDER_COLOR=$WHITE

export SHADOW_COLOR=$BLACK