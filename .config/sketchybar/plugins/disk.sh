#!/usr/bin/env bash

sketchybar --set "$NAME" label="$(df -lh | grep "/System/Volumes/Data" | awk '{ printf ("%02.0f\n", $5) }')%"
