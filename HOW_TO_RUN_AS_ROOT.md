# How to Run Instainsane as Root

Instainsane requires root privileges to run properly. This guide explains how to run the tool as root.

## Method 1: Using the Wrapper Script (Recommended)

We've created a wrapper script that makes it easy to run Instainsane as root:

1. Make the wrapper script executable:
   ```bash
   chmod +x run_as_root.sh
   ```

2. Run the script with sudo:
   ```bash
   sudo ./run_as_root.sh
   ```

   Or if you want to resume a session:
   ```bash
   sudo ./run_as_root.sh --resume
   ```

## Method 2: Running the Main Script Directly

You can also run the main script directly with sudo:

1. Make the main script executable:
   ```bash
   chmod +x instainsane.sh
   ```

2. Run the script with sudo:
   ```bash
   sudo ./instainsane.sh
   ```

   Or if you want to resume a session:
   ```bash
   sudo ./instainsane.sh --resume
   ```

## Method 3: Switch to Root User First

If you prefer, you can switch to the root user first and then run the script:

1. Switch to the root user:
   ```bash
   sudo su
   ```

2. Make the script executable:
   ```bash
   chmod +x instainsane.sh
   ```

3. Run the script:
   ```bash
   ./instainsane.sh
   ```

## Installing Dependencies

Before running Instainsane, you need to install the required dependencies:

1. Make the installation script executable:
   ```bash
   chmod +x install.sh
   ```

2. Run the installation script with sudo:
   ```bash
   sudo ./install.sh
   ```

This will install Tor, OpenSSL, and cURL, which are required for Instainsane to work properly.