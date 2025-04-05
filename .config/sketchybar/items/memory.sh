#!/usr/bin/env bash

source "$CONFIG_DIR/icons.sh"

memory=(
  update_freq=5
  icon="$MEMORY"
  icon.padding_left=10
  label.padding_right=10
  background.padding_right=5
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  background.drawing=on
  script="$PLUGIN_DIR/memory.sh"
)

sketchybar --add item memory right \
           --set memory "${memory[@]}" 
