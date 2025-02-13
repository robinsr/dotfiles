#!/usr/bin/env zsh

dark_purple=$(set_alpha $PURPLE 60)
dark_purple2=$(color_darken $PURPLE 40)

label_color=$(color_darken $CLAY 75)


BOX=(
  background.padding_left=5
  background.padding_right=50
  background.color=$dark_purple
  background.corner_radius=5
  background.drawing=on
  background.height=26
  background.shadow.drawing=on
  background.shadow.color=$dark_purple2
  background.shadow.angle=45
  background.shadow.distance=2
)

function add_stat {
  local stat=$1
  local baritem=$2
  local group="stat-$stat"
  

  sketchybar --add alias $baritem right
  sketchybar --set $baritem alias.scale=1.1 padding_left=0 padding_right=0
  
  sketchybar --add item $stat right 
  sketchybar --set $stat icon="$3" padding_left=6 \
   padding_right=-8 \
   icon.color=$label_color
  
  sketchybar --add bracket $group $stat $baritem
  sketchybar --set $group "${BOX[@]}"

  sketchybar --add item $stat.$lpad right 
  sketchybar --set $stat.$lpad padding_left=0 padding_right=12
}

# click_script="$PLUGIN_DIR/click-space.sh $sid"
# script="$PLUGIN_DIR/update-spaces.sh"