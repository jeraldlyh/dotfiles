#!/usr/bin/env bash

OBSIDIAN_FILE_PATH="$HOME/iCloud/Vault"

function weekly() {
  current_date=$(date +%Y-%m-%d)
  current_day_of_week=$(date +%u)

  days_to_subtract=$((current_day_of_week - 1))

  current_epoch=$(date -u +%s)
  week_start_epoch=$((current_epoch - days_to_subtract * 86400))
  week_start_date=$(date -u -r "$week_start_epoch" +%Y-%m-%d)

  weekly_folder="$OBSIDIAN_FILE_PATH/05 - Work/UBS/Standups"
  file_name="$week_start_date.md"

  if [ -f "$weekly_folder/$file_name" ]; then
    nvim "$weekly_folder/$file_name"
    return 0
  fi

  touch "$weekly_folder/$file_name" >> /dev/null 2>&1

  if [ $? -ne 0 ]; then
    >&2 echo "Failed to create file: $weekly_folder/$file_name"
    return 1
  fi
  nvim "$weekly_folder/$file_name"
}

function vault() {
  nvim "$OBSIDIAN_FILE_PATH"
}
