#!/usr/bin/env zsh

source $HOME/.config/yabai/user/yabai-query.zsh
source $HOME/.config/yabai/user/log.zsh

# ya_cycle_layout () {
#   # Consider what order the layouts should be cycled in:
#   #
#   #   - When cycling stack -> float, windows stay in 'stack' mode until
#   #     manually resized, eg full-size windows
#   #
#   #   - When cycling bsp -> float, windows are already arranged by the 'bsp'
#   #     algorithm. For me this makes more sense as I am usually switching to
#   #     float mode to have more control over multi-window tiling, and
#   #     starting from the previous stack mode means I have to resize multiple
#   #     full-size windows
#   #
#   layouts=(bsp float stack)

#   # Get the currently applied layout
#   current=$(ya_get_layout)

#   # Next layout to be applied. Needs to start as the first
#   next=$layouts[1]


#   for ((i = 1; i <= $#layouts; i++)); do
#     if [[ $layouts[i] == $current ]]; then
#       if (( i != 3 )); then
#         next=$layouts[i+1]
#       fi
#     fi
#   done

#   space="${1:-mouse}"

#   __ya_log "Changing layout ($current->$next, space: $space)"

#   yabai -m space $space --layout $next

#   ya_notify "Layout changed to $next"

#   if [[ -n "${commands[sketchybar]}" ]]; then
#     sketchybar --trigger ya_layout_change YA_SPACE_ID=$(ya_get_active 'space-num') YA_LAYOUT=$next
#   fi

#   # Still need this?
#   echo $next
# }


has_sibling () {
  (ya_query --windows --window $1 &> /dev/null); echo "$?"
}

ya_cycle_focus_ccw () {
  local layout=$(ya_get_layout)
  select=''

  if [[ $layout == 'stack' ]]; then
    select=$([ $(has_sibling 'stack.next') -eq 0 ] && echo "stack.next" || echo "stack.first")
  fi

  if [[ $layout == 'bsp' ]]; then
    select=$([ $(has_sibling next) -eq 0 ] && echo "next" || echo "first")
  fi

  if [[ -n $select ]]; then
    ya_notify "$layout; focus: $select" "Cycle Focus Anti-CW"
    yabai -m window --focus $select
  fi
}

ya_cycle_focus_cw () {
  local layout=$(ya_get_layout)
  select=''

  if [[ $layout == 'stack' ]]; then
    select=$([ $(has_sibling 'stack.prev') -eq 0 ] && echo "stack.prev" || echo "stack.last")
  fi

  if [[ $layout == 'bsp' ]]; then
    select=$([ $(has_sibling prev) -eq 0 ] && echo "prev" || echo "last")
  fi

  if [[ -n $select ]]; then
    ya_notify "$layout; focus: $select" "Cycle Focus CW"
    yabai -m window --focus $select
  fi
}

ya_cycle_pos_cw () {
  # Dont cache; can cycle windows quickly
  win=$(ya_query --windows --window last | jq '.id')

  while : ; do
    yabai -m window $win --swap prev &> /dev/null
    if [[ $? -eq 1 ]]; then
      break
    fi
  done
}

ya_cycle_pos_ccw () {
  # Dont cache; can cycle windows quickly
  win=$(ya_query --windows --window first | jq '.id')

  while : ; do
    yabai -m window $win --swap next &> /dev/null
    if [[ $? -eq 1 ]]; then
      break
    fi
  done
}

ya_throw_next_space () {
  win=$(ya_get_active)
  # disp=$(ya_get_active 'dispId')

  yabai -m window --space next
  yabai -m window --focus $win
}

ya_throw_prev_space () {
  win=$(ya_get_active)

  yabai -m window --space prev
  yabai -m window --focus $win
}

ya_throw_display_west () {
  win=$(ya_get_active)

  yabai -m window --display west
  yabai -m window --focus $win
}

ya_throw_display_east () {
  win=$(ya_get_active)

  yabai -m window --display east
  yabai -m window --focus $win
}
