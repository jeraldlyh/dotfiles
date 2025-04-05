#!/usr/bin/env bash

calendar=(
  icon=􀐫
  icon.padding_right=3
  label.align=right
  update_freq=30
  script="$PLUGIN_DIR/calendar.sh"
)

sketchybar --add item calendar right       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke
