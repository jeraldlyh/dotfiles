#!/usr/bin/env bash

INTERFACE=$(route get default | grep "interface" | cut -d ":" -f 2 | xargs)
UPLOAD_AND_DOWNLOAD=$(ifstat -i "$INTERFACE" -b 0.5 1 | tail -n1)
DOWNLOAD=$(echo "$UPLOAD_AND_DOWNLOAD" | awk '{print $1}' | cut -f1 -d ".")
UPLOAD=$(echo "$UPLOAD_AND_DOWNLOAD" | awk '{print $2}' | cut -f1 -d ".")

DOWNLOAD_FORMAT=$(awk -v d="$DOWNLOAD" 'BEGIN { printf(d > 999 ? "%.1f Mbps" : "%.0f kbps", d > 999 ? d/1000 : d) }')
UPLOAD_FORMAT=$(awk -v u="$UPLOAD" 'BEGIN { printf(u > 999 ? "%.1f Mbps" : "%.0f kbps", u > 999 ? u/1000 : u) }')

HIGHLIGHT_DOWNLOAD=$( [ "$DOWNLOAD" -gt 0 ] && echo "on" || echo "off" )
HIGHLIGHT_UPLOAD=$( [ "$UPLOAD" -gt 0 ] && echo "on" || echo "off" )

sketchybar --set download label="$DOWNLOAD_FORMAT" icon.highlight="$HIGHLIGHT_DOWNLOAD" label.highlight="$HIGHLIGHT_DOWNLOAD" \
           --set upload label="$UPLOAD_FORMAT" icon.highlight="$HIGHLIGHT_UPLOAD" label.highlight="$HIGHLIGHT_UPLOAD"
