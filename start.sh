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
    osascript -e "activate app \"$i\""
    osascript -e 'tell application "System events" to keystroke "f" using {command down, control down}'
done

echo "end with fullscreen start"

echo "start with varios name apps"

for key in "${!various_name_apps[@]}"
do
    echo "$key"="${various_name_apps[$key]}"

    open -a "Docker"

    sleep 5

    osascript -e '
    tell application "System Events"
        if exists process "Docker Desktop" then
            set visible of process "Docker Desktop" to false
        end if
    end tell
    '
done

echo "end with various name apps"
