#!/usr/bin/env sh

source $HOME/.config/yabai/user/yabai-util.zsh

skhd --start-service

fswatch -o ./ | while read num ;
do
  echo "$(date '+%Y-%m-%dT%H:%M:%S') - Reloading SKHD on config change ($num file/s changed)"
  ya_exec 'Reloading SKHD on config change' 'skhd --restart-service'
done
