#!/usr/bin/env bash 

sketchybar --add event aerospace_workspace_change

declare -A monitors
while IFS=" " read -r monitor_id display_id; do
  monitors["$monitor_id"]="$display_id"
done < <(aerospace list-monitors --format '%{monitor-id} %{monitor-appkit-nsscreen-screens-id}')


# for monitor in $(aerospace list-monitors | awk '{print $1}'); do
for monitor in "${monitors[@]}"; do
  for sid in $(aerospace list-workspaces --monitor $monitor); do
    apps=$(aerospace list-windows --workspace $sid | awk -F '|' '{gsub(/^ *| *$/, "", $2); print $2}')

    icon_strip=" "
    if [ "$apps" != "" ]; then
      while read -r app
      do
        icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
      done <<< "$apps"
    else
      icon_strip="—"
    fi

    space=(
      space=$sid
      icon=$sid
      icon.highlight_color=$RED
      icon.padding_left=10
      icon.padding_right=10
      display=$monitor
      padding_left=2
      padding_right=2
      label="$icon_strip"
      label.padding_right=20
      label.color=$GREY
      label.highlight_color=$WHITE
      label.font="sketchybar-app-font:Regular:16.0"
      label.y_offset=-1
      background.color=$BACKGROUND_1
      background.border_color=$BACKGROUND_2
      script="$PLUGIN_DIR/space.sh"
    )

    sketchybar --add space space.$sid left \
               --set space.$sid "${space[@]}" \
               --subscribe space.$sid mouse.clicked
  done

  # Hides the spaces which does not have any windows
  for empty_sid in $(aerospace list-workspaces --monitor $monitor --empty); do
    sketchybar --set space.$empty_sid display=0
  done
done

space_creator=(
  icon=􀆊
  icon.font="$FONT:Heavy:16.0"
  padding_left=10
  padding_right=8
  label.drawing=off
  display=active
  script="$PLUGIN_DIR/space_windows.sh"
  icon.color=$WHITE
)

sketchybar --add item space_creator left               \
           --set space_creator "${space_creator[@]}"   \
           --subscribe space_creator aerospace_workspace_change
