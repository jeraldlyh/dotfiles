#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

network=(
  update_freq=3
  script="$PLUGIN_DIR/network.sh"
  width=0
)

upload=(
  icon="$NETWORK_UPLOAD"
  icon.padding_left=10
  icon.highlight_color="$YELLOW"
  label.padding_right=10
  label.highlight_color="$YELLOW"
  background.padding_right=5
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  background.drawing=on
)

download=(
  icon="$NETWORK_DOWNLOAD"
  icon.color="$WHITE"
  icon.highlight_color="$YELLOW"
  icon.padding_left=10
  label.padding_right=10
  label.highlight_color="$YELLOW"
  background.padding_right=5
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  background.drawing=on
)

sketchybar --add item network right \
           --set network "${network[@]}" \
           --add item upload right \
           --set upload "${upload[@]}" \
           --add item download right \
           --set download "${download[@]}"
