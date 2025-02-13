#!/usr/bin/env zsh

source $HOME/.config/shared/conf.sh
source $HOME/.config/yabai/user/log.zsh
source $HOME/.config/yabai/user/yabai-query.zsh

export YABAI_BAR_TOP=0
export YABAI_BAR_BOTTOM=30


ya_set_config () {
  __ya_log "Setting config value: '$@'"
  yabai -m config "$@"
}

# WIP
ya_toggle_bar () {
  __ya_log "Updating external_bar setting: 'all:$YABAI_BAR_TOP:$YABAI_BAR_BOTTOM'"
  ya -m config external_bar all:$YABAI_BAR_TOP:$YABAI_BAR_BOTTOM
}

ya_set_label () {
  __ya_log "Setting label for space $1 to '$2'"
  
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

  local screens=$(ya_query_cache --displays)
  local screen_count=$(echo $screens | jq -r 'length')
  local has_external=$(echo $screens | jq -r 'map(select(.frame.w > 2000)) | length > 0 | if . then 1 else 0 end')
  local has_laptop=$(echo $screens | jq -r 'map(select(.frame.w < 2000)) | length > 0 | if . then 1 else 0 end')
  local borders_active=$([ -z "$(launchctl list | grep 'borders')" ] && echo "0" || echo "1")
  local borders_width="${BORDERS_WIDTH:-0}"

  __ya_log "Screens: $screen_count (laptop: $has_laptop, external: $has_external); Borders: (active: $borders_active, width: $borders_width)"

  local settings

  case "$has_external:$has_laptop:$borders_active" in
    0:1:1) settings="stack/4/4/0";;
    0:1:0) settings="stack/0/0/0";;
    *) settings="bsp/12/12/12";;
  esac

  __ya_log "Suggesting (layout/padX/padY/gap): $settings"

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
