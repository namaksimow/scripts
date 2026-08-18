#! /usr/bin/env bash

echo "start app"

fullscreen_apps=(
  "Obsidian"
  "Google Chrome"
  "Visual Studio Code"
)

# minimized_apps=(
#   "Docker"
# )

# hide_apps=()


# for apps, that should run in fullscreen mode
for i in "${fullscreen_apps[@]}"; do
    open -a "$i"
    osascript -e "activate app \"$i\""
    osascript -e 'tell application "System events" to keystroke "f" using {command down, control down}'
done

echo "end with fullscreen start"

# # for apps, that should run in minimized mode
# for i in "${minimized_apps[@]}"; do
#     open -a "$i"
#     osascript -e "activate app \"$i\""
#     osascript -e 'tell application "System events" to keystroke "f" using {command down, control down}'
# done

# ---

# echo "hide app"

# osascript -e 'tell application "System Events" to set visible of process "Obsidian" to false'

# ---

# echo "minimizing window"

# osascript -e 'tell application "Terminal" to set miniaturized of every window whose name is "Obsidian" to true'

# osascript -e 'tell application "System Events" to tell process "Obsidian" to perform action "AXMinimize" of front window'

