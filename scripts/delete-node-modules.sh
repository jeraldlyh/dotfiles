#!/usr/bin/env bash

set -euo pipefail

START_PATH="$1"

if [[ ! -d $START_PATH ]]; then
  >&2 echo "Error: '$START_PATH' is not a directory."
  exit 1
fi

echo "Scanning '$START_PATH' for node_modules directories..."
deleted_count=0
deleted_size=0

while IFS= read -r -d "" dir; do
  size_kb=$(du -sk "$dir" 2>/dev/null | awk '{print $1}')
  size_readable=$(du -sh "$dir" 2>/dev/null | awk '{print $1}')

  printf "\nFound: %s (size: %s)\nDelete this directory? [y/N] " "$dir" "$size_readable"
  read -r -n1 reply < /dev/tty

  case "$reply" in
    [Yy]* )
      rm -rf -- "$dir"
      deleted_count=$((deleted_count + 1))
      deleted_size=$((deleted_size + size_kb))
      printf "\n✔ Deleted $dir.\n"
      ;;
    * )
      printf "\n✘ Skipped $dir.\n"
      ;;
  esac
done < <(find "$START_PATH" -type d -name node_modules -prune -print0)

deleted_size_formatted=$(numfmt --to=iec --suffix=B --format="%.1f" "$((deleted_size * 1024))")

printf '\nSummary: removed %d node_modules director%s, freeing %s.\n' \
       "$deleted_count" \
       "$([[ $deleted_count -eq 1 ]] && echo "y" || echo "ies")" \
       "$deleted_size_formatted"
