#!/usr/bin/env zsh

ya_notify () {
  local title="Yabai"
  [[ -n $2 ]] && title=$2
  if [[ "$(functions)" =~ notifyMe ]]; then
    notifyMe $1 $title
  fi
}

ya_restart() {
  yabai --stop-service
  yabai --start-service
  skhd --stop-service
  skhd --start-service
}

ya_tail_log () {
  tail -f /tmp/yabai_$USER.out.log
}

ya_tail_err () {
  tail -f /tmp/yabai_$USER.err.log
}
