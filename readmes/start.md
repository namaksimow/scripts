# Start Apps Script

A Bash script for automatically starting and organizing a workspace on **macOS**.

The script launches selected applications in fullscreen mode and handles applications whose launch name differs from their process name.

## Features

* Launch multiple applications automatically
* Open selected applications in fullscreen mode
* Handle applications with different application and process names
* Hide application windows while keeping their processes running
* Automate workspace setup on macOS

## Requirements

The script is designed specifically for **macOS** because it uses:

* `open`
* `osascript`
* `AppleScript`
* `System Events`

It also requires a version of **Bash that supports associative arrays** (`declare -A`). 

> **Note:** The Bash version bundled with some versions of macOS does not support associative arrays. If necessary, install a newer Bash version using Homebrew.

The terminal may also require Accessibility permissions to control applications using `System Events`.

You can enable them in:

```text
System Settings → Privacy & Security → Accessibility
```

## Configuration

### Fullscreen Applications

Applications that should be launched in fullscreen mode are defined in the `fullscreen_apps` array:

```bash
fullscreen_apps=(
  "App 1"
  "App 2"
  "App 3"
)
```

Each application is launched using:

```bash
open -a "$i"
```

After the application starts, it is activated:

```bash
osascript -e "activate app \"$i\""
```

The script then sends the standard macOS fullscreen shortcut:

```text
Control + Command + F
```

using AppleScript:

```bash
osascript -e 'tell application "System Events" to keystroke "f" using {command down, control down}'
```

To add another fullscreen application, simply add its name to the array:

```bash
fullscreen_apps=(
  "App 1"
  "App 2"
  "App 3"
  "App 4"
)
```

## Applications With Different Process Names

Some macOS applications are launched using one name but appear in `System Events` under a different process name, for example `Docker Desktop`.

These applications are defined using the `various_name_apps` associative array:

```bash
various_name_apps=(["Docker"]="Docker Desktop")
```

The format is:

```text
["Application Name"]="Process Name"
```

For example:

```text
Docker → Docker Desktop
```

`Docker` is used to launch the application:

```bash
open -a "Docker"
```

while `Docker Desktop` is the process name used by `System Events`.

## How It Works

### 1. Launch Fullscreen Applications

The script iterates through the `fullscreen_apps` array:

```bash
for i in "${fullscreen_apps[@]}"; do
    open -a "$i"

    sleep 1

    osascript -e "activate app \"$i\""

    sleep 1

    osascript -e 'tell application "System Events" to keystroke "f" using {command down, control down}'

    sleep 2
done
```

For every application, the script:

1. Launches the application.
2. Waits for it to start.
3. Brings it to the foreground.
4. Waits for the application to become active.
5. Sends `Control + Command + F`.
6. Waits before launching the next application.

The delays are necessary because application startup and fullscreen transitions are not instantaneous.

## 2. Launch and Hide Other Applications

The script then processes applications from `various_name_apps`:

```bash
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
```

For each entry, the script:

1. Launches the application.
2. Gets its corresponding process name.
3. Waits for the application to finish starting.
4. Checks whether the process exists.
5. Hides the process window.

For Docker, the result is:

```text
Launch Docker
      │
      ▼
Wait for Docker Desktop
      │
      ▼
Hide Docker Desktop window
      │
      ▼
Docker continues running in background
```

## Script Flow

The complete execution flow is:

```text
Start
  │
  ├── Open App 1
  │     └── Enter fullscreen
  │
  ├── Open App 2
  │     └── Enter fullscreen
  │
  ├── Open App 3
  │     └── Enter fullscreen
  │
  ├── Open App 4 name
  │     └── Wait for App 4 process name
  │           └── Hide App 4 process name
  │
  └── Finish
```

## Usage

Make the script executable:

```bash
chmod +x start.sh
```

Run it:

```bash
bash path/start.sh
```

Alternatively, run it directly with Bash:

```bash
bash start.sh
```

## Customization

You can customize the workspace by modifying the arrays at the beginning of the script.

For example:

```bash
fullscreen_apps=(
  "App 1"
  "App 2"
  "App 3"
  "App 4"
)

various_name_apps=(
  ["App name"]="Process name"
)
```

After this change, App 4 will also be launched and switched to fullscreen mode.

## Delays

The script uses several `sleep` commands:

```bash
sleep 1
sleep 2
sleep 7
```

These delays give macOS enough time to launch applications, activate windows, and perform fullscreen transitions.

Application startup time depends on system performance. If an application is not activated or hidden correctly, increase the corresponding delay.

For example:

```bash
sleep 3
```

instead of:

```bash
sleep 1
```

## Limitations

* The script works only on macOS.
* Application names must match the names recognized by `open -a`.
* Fullscreen mode depends on the `Control + Command + F` keyboard shortcut.
* `System Events` requires Accessibility permissions.
* Fixed `sleep` delays may need adjustment depending on application startup time.
* Associative arrays require Bash 4 or newer.

## Purpose

The purpose of this script is to quickly restore a predefined macOS workspace.

Instead of manually opening and organizing applications after starting the computer, run:

```bash
bash path/start.sh
```

The script will automatically launch the required applications, switch selected applications to fullscreen mode, and hide background applications such as Docker Desktop.
