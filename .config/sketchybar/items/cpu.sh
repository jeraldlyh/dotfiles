#!/usr/bin/env bash

source "$CONFIG_DIR/icons.sh"

cpu=(
  update_freq=5
  icon="$CPU"
  icon.padding_left=10
  label.padding_right=10
  background.padding_right=5
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  background.drawing=on
  script="$PLUGIN_DIR/cpu.sh"
)

sketchybar --add item cpu right \
            --set cpu "${cpu[@]}" 
