#!/usr/bin/env bash

print_usage() {
  >&2 echo "Creates a new file in the dailies directory and opens it with nvim."
  >&2 echo 
  >&2 echo "Usage:"
  >&2 echo "  on <file_name>"
}

function on() {
  if [ -z "$1" ]; then
    >&2 echo "File name is required."
    print_usage
    return 1
  fi

  if [ "$#" -gt 1 ]; then
    >&2 echo "Only one argument is allowed."
    print_usage
    return 1
  fi

  file_name="$(date "+%Y-%m-%d")_${file_name}.md"
  file_path="$HOME/iCloud/vaults/notes/dailies"

  if [ -f "$file_path/$file_name" ]; then
    nvim "$file_path/$file_name"
    return 0
  fi

  touch "$file_path/$file_name" >> /dev/null 2>&1

  if [ $? -ne 0 ]; then
    &>2 echo "Failed to create file: $file_path/$file_name"
    return 1
  fi
  nvim "$file_path/$file_name"
}
