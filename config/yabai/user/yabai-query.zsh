#!/usr/bin/env zsh

# Yabai Selectors for Reference
#
# STACK_SEL   := stack.prev | stack.next | stack.first | stack.last | stack.recent
#
# WINDOW_SEL  := prev | next | first | last | recent | mouse | largest | smallest | sibling | first_nephew | second_nephew | uncle | first_cousin | second_cousin | STACK_SEL | DIR_SEL | <window id>
#
# DISPLAY_SEL := prev | next | first | last | recent | mouse | DIR_SEL | <arrangement index (1-based)> | LABEL
#
# SPACE_SEL   := prev | next | first | last | recent | mouse | <mission-control index (1-based)> | LABEL
#
# And some query examples:
#
# yabai -m query --windows | jq '.[] | {id,app,title,role,subrole}'


source $HOME/.config/shared/conf.sh
source $HOME/.config/yabai/user/log.zsh


# Just exists for logging
ya_query () {
  __ya_log "Query (${funcstack[2]:-${0##*/}}) 'yabai -m query $@'"
  yabai -m query "$@"
}

# WIP
# Caches json query results return from 'ya_query_cache' to address performance
# issues when yabai is queried in rapid succession for the same data. The TTL
# only needs to be a few seconds to handle these bursts of query operations
#
# Not positive if this will be more performant
ya_query_cache () {
  ya_query "$@"
  return


  local CACHE_LOCATION="${XDG_CACHE_HOME:-/tmp}"
  
  # Create a file path based on the query params passed to yabai.
  # The filepath is the cache key, the contents are the cache content
  local QUERY="$@"
  local FILE="$CACHE_LOCATION/yabai-query-cache-${QUERY//[[:space:]]/}.json"

  # Creates a temp file with mod-time set to (now - some offset) to compare cached result file to.
  NOW_FILE="$CACHE_LOCATION/yabai-now"
  echo "tmpfile" >> $NOW_FILE
  touch -d "$(date -v -10S '+%-Y-%m-%dT%H:%M:%S')" $NOW_FILE

  
  # Use the cache file contents if the cache file is newer than the temp file
  if [[ -e $FILE ]] && [[ $FILE -nt $NOW_FILE ]]; then
    __ya_log "✅ Using cache file $FILE"

  # Otherwise invoke yabai query and cache result json
  else
    __ya_log "📝 Creating cache file $FILE"
    
    JSON="$(ya_query "$@")"
    RESULT=$?

    if [ $RESULT -eq 0 ]; then
      echo "$JSON" >> $FILE
    else
      __ya_log "yabai query failed"
    fi
  fi

  if [[ -e $FILE ]]; then
    cat $FILE
  fi
}

ya_get_config () {
  yabai -m config $1
}

ya_get_rules () {
  yabai -m rule --list
}

ya_get_layout () {
  # 'mouse' I assume means the space with pointer
  yabai -m config --space "${1:-mouse}" layout
}

ya_get_display_count () {
  echo "$(ya_query_cache --displays | jq 'length')"
}

ya_get_active () {
  case $1 in
    'window') ya_query --windows --window | jq '.';
    ;;
    'window-id') ya_query_cache --windows --window | jq '.id';
    ;;
    'window-title') ya_query_cache --windows --window | jq '.title';
    ;;
    'space') ya_query_cache --spaces --space | jq '.';
    ;;
    'space-id') ya_query_cache --spaces --space | jq '.id'
    ;;
    'space-num') ya_query_cache --spaces --space | jq '.index'
    ;;
    'recent-space-num') ya_query_cache --spaces --space recent | jq '.index'
    ;;
    'space-layout') ya_query_cache --spaces --space | jq -r '.type'
    ;;
    'space-label') ya_query_cache --spaces --space | jq -r '.label'
    ;;
    'display') ya_query_cache --displays --display | jq '.';
    ;;
    'display-id') ya_query_cache --displays --display | jq '.id';
    ;;
    'display-num') ya_query_cache --displays --display | jq '.index';
    ;;
    *) ya_query_cache --windows --window | jq '.id';
  esac
}
