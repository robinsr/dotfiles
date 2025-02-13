#!/usr/bin/env zsh

source $HOME/.config/yabai/user/yabai-query.zsh
source $HOME/.config/yabai/user/yabai-movement.zsh

current=$(ya_get_active space-num)

hs -c "fire('ext:click:sketchybar:spaces', { \
  button='$BUTTON', \
  modifier='$MODIFIER', \
  target='$NAME', \
  sender='$SENDER', \
  args={ '$1', '$2', '$3' } \
})"

if [[ $current == $1 ]]; then
  hs -c "KittySupreme.commands:find('spaces.layout.cycle'):invoke('other')"
else 
  yabai -m space --focus $1
fi


