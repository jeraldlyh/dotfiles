#!/usr/bin/env bash

sketchybar --set $NAME \
  label="Loading..." \
  icon.color=0xff5edaff

LOCATION="Singapore"
REGION=""

# Replace spaces with +
LOCATION_ESCAPED="${LOCATION// /+}+${REGION// /+}"
WEATHER_DATA=$(curl -s "https://wttr.in/$LOCATION_ESCAPED?format=%c%f")

# echo "https://wttr.in/$LOCATION_ESCAPED?0pq&format=j1&lang=en"
if [[  -z "$WEATHER_DATA" || "$WEATHER_DATA" =~ "try" ]]; then
  sketchybar --set $NAME label="$LOCATION" icon.y_offset=0
  exit
fi

LABEL="${WEATHER_DATA:1:${#WEATHER_DATA}-2}"
ICON="$(echo "${WEATHER_DATA:0:1}")"

sketchybar --set $NAME label="$LABEL" icon="$ICON" icon.y_offset=2
