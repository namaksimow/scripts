# Server Stats

A simple Bash script for analyzing basic Linux server performance statistics.

## Requirements

Create a script named `server-stats.sh` that can be run on any Linux server and displays basic server performance information.

The script should provide the following statistics:

- **Total CPU usage**
- **Total memory usage**
  - Used memory
  - Free memory
  - Usage percentage
- **Total disk usage**
  - Used disk space
  - Free disk space
  - Usage percentage
- **Top 5 processes by CPU usage**
- **Top 5 processes by memory usage**

## Usage

Make the script executable:

```bash
chmod +x server-stats.sh
```

Run script

```bash
bash server-stats.sh
```