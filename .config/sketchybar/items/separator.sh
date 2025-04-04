#!/usr/bin/env bash

separator=(
  icon=│
  icon.font="$FONT:Heavy:16.0"
  padding_left=8
  padding_right=8
  label.drawing=off
  display=active
  icon.color=$WHITE
)

sketchybar --add item separator "$1" \
           --set separator "${separator[@]}" 
