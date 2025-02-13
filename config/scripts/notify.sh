#!/usr/bin/env zsh

function notifyMe() {
  MSG=$1
  TITLE="with title \"Term message...\""
  SUB=""

  if [[ -n $2 ]]; then
    TITLE="with title \"$2\""
  fi

  if [[ -n $3 ]]; then
    SUB="subtitle \"$3\""
  fi

	osascript -e "display notification \"${MSG}\" ${TITLE} ${SUB}"
}
