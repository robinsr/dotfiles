#!/usr/bin/env zsh

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
  echo "$(yabai -m query --displays | jq 'length')"
}

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

ya_get_active () {
  case $1 in
    'window') yabai -m query --windows --window | jq '.';
    ;;
    'window-id') yabai -m query --windows --window | jq '.id';
    ;;
    'window-title') yabai -m query --windows --window | jq '.title';
    ;;
    'space') yabai -m query --spaces --space | jq '.';
    ;;
    'space-id') yabai -m query --spaces --space | jq '.id'
    ;;
    'space-num') yabai -m query --spaces --space | jq '.index'
    ;;
    'recent-space-num') yabai -m query --spaces --space recent | jq '.index'
    ;;
    'space-layout') yabai -m query --spaces --space | jq -r '.type'
    ;;
    'space-label') yabai -m query --spaces --space | jq -r '.label'
    ;;
    'display') yabai -m query --displays --display | jq '.';
    ;;
    'display-id') yabai -m query --displays --display | jq '.id';
    ;;
    'display-num') yabai -m query --displays --display | jq '.index';
    ;;
    *) yabai -m query --windows --window | jq '.id';
  esac
}
