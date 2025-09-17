#!/usr/bin/env bash

FILE_PATH="$HOME/iCloud/Vault"

print_usage() {
  >&2 echo "Creates a new file in the dailies directory and opens it with nvim."
  >&2 echo 
  >&2 echo "Usage:"
  >&2 echo "  daily <file_name>"
}

function daily() {

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

  current_date=$(date +%Y-%m-%d)
  daily_folder="$FILE_PATH/dailies"
  file_name="${current_date}_$1.md"

  if [ -f "$daily_folder/$file_name" ]; then
    cd "$daily_folder" && nvim
    return 0
  fi

  touch "$daily_folder/$file_name" >> /dev/null 2>&1

  if [ $? -ne 0 ]; then
    >&2 echo "Failed to create file: $daily_folder/$file_name"
    return 1
  fi
  cd "$daily_folder" && nvim
}

function weekly() {
  current_date=$(date +%Y-%m-%d)
  current_day_of_week=$(date +%u)

  days_to_subtract=$((current_day_of_week - 1))

  current_epoch=$(date -u +%s)
  week_start_epoch=$((current_epoch - days_to_subtract * 86400))
  week_start_date=$(date -u -r "$week_start_epoch" +%Y-%m-%d)

  weekly_folder="$FILE_PATH/weeklies"
  file_name="$week_start_date.md"

  if [ -f "$weekly_folder/$file_name" ]; then
    cd "$weekly_folder" && nvim
    return 0
  fi

  touch "$weekly_folder/$file_name" >> /dev/null 2>&1

  if [ $? -ne 0 ]; then
    >&2 echo "Failed to create file: $weekly_folder/$file_name"
    return 1
  fi
  cd "$weekly_folder" && nvim
}
