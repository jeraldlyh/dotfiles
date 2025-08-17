#!/usr/bin/env bash

DJI_PATH="$1"
TEMP_DIR="/tmp/lrf"

if [[ -z "$DJI_PATH" || ! -d "$DJI_PATH"  ]]; then
  >&2 echo "DJI_PATH is not set. Please set it to the path where your DJI files are located."
  exit 1
fi

if [ ! -d "$TEMP_DIR" ]; then
  mkdir -p "$TEMP_DIR"
  echo "Created temporary directory at $TEMP_DIR."
fi

mv "$DJI_PATH"/*.LRF "$TEMP_DIR/"

echo "Moved all .LRF files from $DJI_PATH to $TEMP_DIR."
