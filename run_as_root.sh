#!/bin/bash
# Wrapper script to run instainsane.sh as root
# Author: SOTA-agent

# Check if running as root
if [[ "$(id -u)" -ne 0 ]]; then
    echo -e "\e[1;91m[!] Error: This program must be run as root!\e[0m"
    echo -e "\e[1;92m[*] Run the script using one of these methods:\e[0m"
    echo -e "\e[1;77m    - sudo ./run_as_root.sh\e[0m"
    echo -e "\e[1;77m    - sudo bash run_as_root.sh\e[0m"
    echo -e "\e[1;77m    - Or switch to root user first with 'sudo su' and then run './run_as_root.sh'\e[0m"
    exit 1
fi

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Make sure instainsane.sh is executable
chmod +x "$SCRIPT_DIR/instainsane.sh"

# Run the main script
echo -e "\e[1;92m[*] Running instainsane.sh as root...\e[0m"
"$SCRIPT_DIR/instainsane.sh" "$@"