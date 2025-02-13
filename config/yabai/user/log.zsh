#!/usr/bin/env zsh

function __ya_log () {
  local -r log_file="${XDG_CACHE_HOME:-$HOME}/.yabai.log"
  local -r caller="${funcstack[2]:-${0##*/}}"
  echo "$(date '+%Y-%m-%dT%H:%M:%S') $(printf %20s $caller) - $@" >> $log_file
}
