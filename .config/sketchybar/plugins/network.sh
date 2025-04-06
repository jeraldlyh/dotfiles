#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

INTERFACE=$(route get default | grep "interface" | cut -d ":" -f 2 | xargs)
UPLOAD_AND_DOWNLOAD=$(ifstat -i "$INTERFACE" -b 0.5 1 | tail -n1)
DOWNLOAD=$(echo "$UPLOAD_AND_DOWNLOAD" | awk '{print $1}' | cut -f1 -d ".")
UPLOAD=$(echo "$UPLOAD_AND_DOWNLOAD" | awk '{print $2}' | cut -f1 -d ".")

DOWNLOAD_FORMAT=$(awk -v d="$DOWNLOAD" 'BEGIN { printf(d > 999 ? "%.1f Mbps" : "%.0f kbps", d > 999 ? d/1000 : d) }')
UPLOAD_FORMAT=$(awk -v u="$UPLOAD" 'BEGIN { printf(u > 999 ? "%.1f Mbps" : "%.0f kbps", u > 999 ? u/1000 : u) }')

case $DOWNLOAD in
  [0])
    DOWNLOAD_COLOR="$WHITE"
    ;;
  [1-9]|[1-9][0-9])
    DOWNLOAD_COLOR="$GREEN"
    ;;
  [1-9][0-9][0-9]|1000)
    DOWNLOAD_COLOR="$YELLOW"
    ;;
  [1-9][0-9][0-9][0-9]|10000)
    DOWNLOAD_COLOR="$RED"
    ;;
esac

case $UPLOAD in
  [0])
    UPLOAD_COLOR="$WHITE"
    ;;
  [1-9]|[1-9][0-9])
    UPLOAD_COLOR="$GREEN"
    ;;
  [1-9][0-9][0-9]|1000)
    UPLOAD_COLOR="$YELLOW"
    ;;
  [1-9][0-9][0-9][0-9]|10000)
    UPLOAD_COLOR="$RED"
    ;;
esac

sketchybar --set download label="$DOWNLOAD_FORMAT" icon.color="$DOWNLOAD_COLOR" label.color="$DOWNLOAD_COLOR" \
           --set upload label="$UPLOAD_FORMAT" icon.color="$UPLOAD_COLOR" label.color="$UPLOAD_COLOR"
