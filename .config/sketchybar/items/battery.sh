#!/usr/bin/env bash

battery=(
  icon.font="$FONT:Regular:16.0"
  padding_right=0
  padding_left=0
  label.drawing=off
  update_freq=120
  updates=on
  script="$PLUGIN_DIR/battery.sh"
)
sketchybar --add item battery right \
           --set battery "${battery[@]}" \
           --subscribe battery power_source_change system_woke
