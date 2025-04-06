#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

USAGE=$(ps -A -o %cpu | awk '{s+=$1} END {print s /= 8}')
IS_HIGHLIGHTED=$(awk -v usage="$USAGE" -v threshold="$THRESHOLD" 'BEGIN { print (usage > threshold ? "on" : "off") }')

case ${USAGE%.*} in
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
  label="$(printf "%.1f%%" "$USAGE")" \
  icon.color="$COLOR" \
  label.color="$COLOR"
