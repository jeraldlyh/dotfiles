#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

FREE_PERCENT=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{ gsub("%", "", $5); print $5 }')
USAGE=$((100 - FREE_PERCENT))

case ${USAGE} in
  [0-9]|1[0-9]|2[0-9])
    COLOR="$WHITE"
    ;;
  [3-6][0-9]) 
    COLOR="$YELLOW"
    ;;
  [7-9][0-9]|100)
    COLOR="$RED"
    ;;
esac

sketchybar --set "$NAME" \
  label="$USAGE%" \
  icon.color="$COLOR" \
  label.color="$COLOR"
