# Scripts

A collection of Bash and AppleScript scripts for macOS 
and automation.

## Scripts Description

| Script | Description | Documentation |
|---|---|---|
| `start.sh` | Runs the apps in your specific way | [Read more](readmes/start.md) |
| `end.sh` | Close all running apps | [Read more](readmes/end.md) 

## Requirements

- macOS
- Bash 4+
- AppleScript

## Usage

Clone the repository:

```bash
git clone https://github.com/namaksimow/scripts.git
cd scripts
```

## Roadmap / TODO

### `start.sh`

- [x] Launch applications
- [x] Open applications in fullscreen mode
- [x] Open applications in hide mode
- [ ] Add application groups/profiles
- [ ] Add command-line arguments
- [ ] Check if an application is already running
- [ ] Add error handling
- [ ] Add configuration file support
- [ ] Execution script from root `\`

### `end.sh`
 - [ ] Close applications in not fullscreen mode
 - [ ] Close applications in fullscreen mode
 - [ ] Add applications group/profiles
 - [ ] Add command-line arguments
 - [ ] Check if an application is already closed
 - [ ] Add error handling
 - [ ] Add configuration file support
 - [ ] Execution script from `\`