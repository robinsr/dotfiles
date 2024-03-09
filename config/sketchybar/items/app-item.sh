app_props=(
    icon.drawing=off
    script="$PLUGIN_DIR/update-app.sh"
)

sketchybar --add item front_app left \
           --set front_app ${app_props[@]} \
           --subscribe front_app front_app_switched ya-window-event