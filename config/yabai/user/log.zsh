#!/usr/bin/env zsh

function __ya_log () {
  local -r log_file="${XDG_CACHE_HOME:-$HOME}/.yabai.log"
  local -r caller="${funcstack[0]}"
  echo "$(date '+%Y-%m-%dT%H:%M:%S') ($caller) - $@" >> $log_file
}
