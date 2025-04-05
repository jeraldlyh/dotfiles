#!/usr/bin/env bash

separator=(
  icon=│
  icon.font="$FONT:Heavy:16.0"
  padding_left=4
  padding_right=4
  label.drawing=off
  icon.color=$WHITE
)

sketchybar --add item "$1" "$2" \
           --set "$1" "${separator[@]}" 
