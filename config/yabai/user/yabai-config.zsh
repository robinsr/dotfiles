#!/usr/bin/env zsh

export YABAI_BAR_TOP=0
export YABAI_BAR_BOTTOM=30

source $HOME/.config/yabai/user/log.zsh

ya_set_config () {
  yabai -m config "$@"
}

ya_toggle_bar () {
  ya -m config external_bar all:$YABAI_BAR_TOP:$YABAI_BAR_BOTTOM
}

ya_set_label () {
  yabai -m space $1 --label $2

  if [[ -n "${commands[sketchybar]}" ]]; then
    sketchybar --trigger ya_new_label YA_SPACE_ID=$1 YA_LABEL=$2
  fi
}

# Suggests configuration values for yabai based on the current conditions.
function ya_suggest {
  if [[ -z "$1" ]]; then
    echo "Usage: ya_suggest <layout|padding-x|padding-y|gap>"
    return 1
  fi

  local screens=$(yabai -m query --displays)
  local screen_count=$(echo $screens | jq -r 'length')
  local has_external=$(echo $screens | jq -r 'map(select(.frame.w > 2000)) | length > 0 | if . then 1 else 0 end')
  local has_laptop=$(echo $screens | jq -r 'map(select(.frame.w < 2000)) | length > 0 | if . then 1 else 0 end')
  local borders_active=$([ -z "$(launchctl list | grep 'borders')" ] && echo "0" || echo "1")

  local settings

  case "$has_external:$has_laptop:$borders_active" in
    0:1:1) settings="stack/4/4/0";;
    0:1:0) settings="stack/0/0/0";;
    *) settings="bsp/12/12/12";;
  esac

  __ya_log "ya_suggest - Screens: $screen_count (laptop: $has_laptop, external: $has_external, borders: $borders_active)"

  case "$1" in
    layout) echo $settings | cut -d'/' -f1;;
    padding-x) echo $settings | cut -d'/' -f2;;
    padding-y) echo $settings | cut -d'/' -f3;;
    gap) echo $settings | cut -d'/' -f4;;
    *)
      echo "Unknown suggestion: $1"
      return 1
      ;;
  esac
}
