#!/usr/bin/env zsh

source $HOME/.config/yabai/user/yabai-query.zsh
source $HOME/.config/yabai/user/log.zsh

ya_cycle_layout () {
  # Consider what order the layouts should be cycled in:
  #
  #   - When cycling stack -> float, windows stay in 'stack' mode until
  #     manually resized, eg full-size windows
  # 
  #   - When cycling bsp -> float, windows are already arranged by the 'bsp'
  #     algorithm. For me this makes more sense as I am usually switching to
  #     float mode to have more control over multi-window tiling, and
  #     starting from the previous stack mode means I have to resize multiple
  #     full-size windows
  #
  layouts=(bsp float stack)

  # Get the currently applied layout
  current=$(ya_get_layout)

  # Next layout to be applied. Needs to start as the first 
  next=$layouts[1]
  __ya_log "layouts[1]: '$next'"


  for ((i = 1; i <= $#layouts; i++)); do
    if [[ $layouts[i] == $current ]]; then
      if (( i != 3 )); then
        next=$layouts[i+1]
      fi
    fi
  done

  __ya_log "Changing layout from '$current' to '$next'"

  yabai -m space --layout $next

  ya_notify "Layout changed to $next"

  if [[ -n "${commands[sketchybar]}" ]]; then
    sketchybar --trigger ya_layout_change YA_SPACE_ID=$(ya_get_active 'space-num') YA_LAYOUT=$next
  fi

  # Still need this?
  echo $next
}

ya_cycle_focus_cw () {
  local layout=$(ya_get_layout)

  if [[ $layout -eq 'stack' ]]; then
    yabai -m window --focus stack.next &> /dev/null
    [[ $? -eq 1 ]] && yabai -m window --focus stack.first
  fi

  if [[ $layout -eq 'bsp' ]]; then
    yabai -m window --focus next &> /dev/null
    [[ $? -eq 1 ]] && yabai -m window --focus first
  fi
}

ya_cycle_focus_ccw () {
  local layout=$(ya_get_layout)

  if [[ $layout -eq 'stack' ]]; then
    yabai -m window --focus stack.prev &> /dev/null
    [[ $? -eq 1 ]] && yabai -m window --focus stack.last
  fi

  if [[ $layout -eq 'bsp' ]]; then
    yabai -m window --focus prev &> /dev/null
    [[ $? -eq 1 ]] && yabai -m window --focus last
  fi
}

ya_cycle_pos_cw () {
  win=$(yabai -m query --windows --window last | jq '.id')

  while : ; do
    yabai -m window $win --swap prev &> /dev/null
    if [[ $? -eq 1 ]]; then
      break
    fi
  done
}

ya_cycle_pos_ccw () {
  win=$(yabai -m query --windows --window first | jq '.id')

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

ya_throw_next_display () {
  win=$(ya_get_active)

  yabai -m window --display next
  yabai -m window --focus $win
}

ya_throw_prev_display () {
  win=$(ya_get_active)

  yabai -m window --display prev
  yabai -m window --focus $win
}
