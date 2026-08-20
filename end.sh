declare -A various_name_apps

fullscreen_apps=(
  "Obsidian"
  "Google Chrome"
  "Visual Studio Code"
)

various_name_apps=(["Docker"]="Docker Desktop")

for i in "${fullscreen_apps[@]}"; do
    osascript -e "quit app \"$i\""

    sleep 1
done