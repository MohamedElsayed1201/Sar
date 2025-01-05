#!/bin/bash

#set -x # Enable debug mode for tracing commands
#set -v # Enable verbose mode for tracing commands
#set -e # Exit immediately if a command exits with a non-zero status

# Ensure required commands are installed
command -v sar >/dev/null 2>&1 || {
    echo "Command 'sar' not found, but can be installed with:"
    echo "sudo apt install sysstat"
    echo "Please ask your administrator."
    echo "Exiting..."
    exit 1
}

# Constants
LOG_DIR="$HOME/local/log"           # Base Log directory
LOG_FILE="$LOG_DIR/sarnetwork.log"  # Main script log file

# Check if the LOG_DIR directory is writable
if [ ! -w "$LOG_DIR" ]; then
    echo "No write permission to the home directory $LOG_DIR. Aborting."
    exit 1
else
    echo "Write permission confirmed for $LOG_DIR."
fi

# Check if the LOG_DIR exists, if not create it
if [ ! -d "$LOG_DIR" ]; then
    mkdir -p "$LOG_DIR" || { echo "Failed to create directory $LOG_DIR. Aborting."; exit 1; }
    echo "Created directory: $LOG_DIR"
else
    echo "Directory $LOG_DIR already exists."
fi

# Create log file
exec > >(tee -a "$LOG_FILE") 2>&1
echo "[$(date +'%m-%d-%Y %H:%M:%S')] Starting network traffic collection..."

# Ensure sudo permissions are granted (check before using)
if ! sudo -v; then
    echo "Sudo permission required to run the sar command. Exiting..."
    exit 1
fi

# Get the network traffic every 1 second for 25 times
sudo sar -n DEV 1 25 >> "$LOG_FILE" 2>&1 || { echo "sar command failed. Check permissions."; exit 1; }

echo "Network traffic inspection completed. Check the log file at: $LOG_FILE"

# Optional: Consider keeping the log file for historical reference
# Uncomment the next line if you want to keep the log file after the script finishes
# echo "Log file saved at: $LOG_FILE"

# Cleanup function to remove the temporary files (optional, depends on preference)
cleanup() {
    rm -f "$LOG_FILE"
}
trap cleanup EXIT

exit 0

