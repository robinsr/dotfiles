#!/usr/bin/env zsh

source $HOME/.config/shared/conf.sh
source $HOME/.config/yabai/user/log.zsh

ya_notify () {
  local title="Yabai"
  [[ -n $2 ]] && title=$2
  if [[ "$(functions)" =~ notifyMe ]]; then
    __ya_log "Sending notification: '$title' '$1'"
    notifyMe $1 $title
  else
    __ya_log "⛔️ No function 'notifyMe'"
  fi
}

ya_exec () {
  local cmd_name=$1
  local cmd=$2

  # ya_notify "$cmd_name"
  hs -c "ipc.trigger('$cmd_name')"
  eval "$2"
}

ya_restart() {
  __ya_log "⛔️ Restarting yabai"

  yabai --stop-service
  yabai --start-service

  if [[ "$@" =~ 'skhd' ]]; then
    __ya_log "⛔️ Restarting skhd"
    skhd --stop-service
    skhd --start-service
  fi
}

ya_tail_log () {
  tail -f /tmp/yabai_$USER.out.log
}

ya_tail_err () {
  tail -f /tmp/yabai_$USER.err.log
}
