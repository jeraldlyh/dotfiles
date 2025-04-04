#!/usr/bin/env bash

sketchybar --add item weather right \
  --set weather \
  icon=󰖐 \
  script="$PLUGIN_DIR/weather.sh" \
  label.font="$FONT:Bold:12.0" \
  update_freq=1500 \
  --subscribe weather mouse.clicked
