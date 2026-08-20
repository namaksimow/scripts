#! /usr/bin/env bash

fullscreen_apps=(
  "Obsidian"
  "Google Chrome"
  "Visual Studio Code"
)

minimized_apps=(
  "Docker Desktop"
)

echo "start with fullscreen apps"

# for apps that should run in fullscreen mode
for i in "${fullscreen_apps[@]}"; do
    open -a "$i"
    osascript -e "activate app \"$i\""
    osascript -e 'tell application "System events" to keystroke "f" using {command down, control down}'
done

echo "end with fullscreen start"

echo "start with minimized apps"

# for apps that should run on minimized mode (for example docker desktop)
for i in "${minimized_apps[@]}"; do
    echo "$i"
    open -a "$i"
    osascript -e "activate app \"$i\""
    osascript -e 'tell application "System events" to keystroke "m" using {command down}'
done

echo "end with minimized apps"