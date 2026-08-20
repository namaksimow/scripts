#! /usr/bin/env bash

declare -A various_name_apps

fullscreen_apps=(
  "Obsidian"
  "Google Chrome"
  "Visual Studio Code"
)

# when you start Docker, starts Docker Desktop, so you should open Docker and hide Docker Desktop
various_name_apps=(["Docker"]="Docker Desktop")

echo "start with fullscreen apps"

# for apps that should run in fullscreen mode
for i in "${fullscreen_apps[@]}"; do
    open -a "$i"

    sleep 1

    osascript -e "activate app \"$i\""

    sleep 1

    osascript -e 'tell application "System events" to keystroke "f" using {command down, control down}'
    
    sleep 2
done

echo "end with fullscreen start"

echo "start with varios name apps"

for key in "${!various_name_apps[@]}"; do
    open -a "$key"

    process_name="${various_name_apps[$key]}"

    sleep 7

    osascript -e "
    tell application \"System Events\"
        if exists process \"$process_name\" then
            set visible of process \"$process_name\" to false
        end if
    end tell
    "
done

echo "end with various name apps"
