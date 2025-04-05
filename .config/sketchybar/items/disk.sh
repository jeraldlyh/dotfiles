#!/usr/bin/env bash

source "$CONFIG_DIR/icons.sh"

disk=(
  update_freq=600
  icon="$DISK"
  icon.padding_left=10
  label.padding_right=10
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  background.drawing=on
  padding_right=10
  script="$PLUGIN_DIR/disk.sh"
)

sketchybar --add item disk right \
            --set disk "${disk[@]}" 
