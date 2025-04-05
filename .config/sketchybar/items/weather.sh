#!/usr/bin/env bash

weather=(
  icon=󰖐
  icon.font="$FONT:Bold:12.0"
  icon.padding_left=5
  icon.padding_right=0
  label.font="$FONT:Bold:12.0"
  update_freq=1500
  script="$PLUGIN_DIR/weather.sh"
  background.padding_right=5
)

sketchybar --add item weather right \
  --set weather "${weather[@]}" \
  --subscribe weather mouse.clicked
