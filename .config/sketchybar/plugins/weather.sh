#!/usr/bin/env bash

sketchybar --set $NAME \
  label="Loading..." \
  icon.color=0xff5edaff

WEATHER_DATA=$(curl -s "https://wttr.in/Singapore?format=%c+%t")

if [[ -z "$WEATHER_DATA" || "$WEATHER_DATA" =~ "try" ]]; then
  sketchybar --set $NAME label="N/A" icon.y_offset=0
  exit
fi

ICON=$(echo "$WEATHER_DATA" | cut -d' ' -f1)
LABEL=$(echo "$WEATHER_DATA" | cut -d' ' -f2-)

ICON=$(echo "$ICON" | sed 's/️//g')  # Removes invisible variation selector if present

sketchybar --set $NAME label="$LABEL" icon="$ICON" icon.y_offset=2 label.padding_left=0
