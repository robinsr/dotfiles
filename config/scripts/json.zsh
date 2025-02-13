#!/usr/bin/env zsh

# Converts all arguments to a JSON string
function argstojson {
  local args=("$@")
  local json="{"
  for i in "${!args[@]}"; do
    if [ $((i % 2)) == 0 ]; then
      if [ $i -gt 0 ]; then
        json="$json,"
      fi
      json="$json\"${args[i]}\":\"${args[i+1]}\""
    fi
  done
  json="$json}"
  echo $json
}
