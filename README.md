# Unraid ZeroTier Server Restart Fix Script

## Overview
This script is designed to address a common issue on Unraid servers where the Nginx service starts before the ZeroTier container following a server restart. Typically, this results in the Unraid web UI not being accessible through ZeroTier unless the Nginx configuration is manually reloaded after the ZeroTier container is running. This script automates the reloading of the Nginx configuration once the ZeroTier container is operational, ensuring that the server remains accessible from ZeroTier after a restart.

## Prerequisites
- Unraid server with the ZeroTier container installed.
- User Scripts plugin installed on your Unraid server.

## How It Works
The script performs the following operations:
1. **Check Docker Service**: Ensures the Docker service is running on Unraid, before the script starts.
2. **Check ZeroTier Container**: Monitors the status of the ZeroTier container to confirm it is up and running before starting process.
3. **Validate and Restart Nginx**: Validates the Nginx configuration and restarts the service to apply any changes needed to fix the ZeroTier connectivity.

## Configuration
The script includes several user-configurable variables to adapt to your specific setup:

- `wait_time_docker_service`: Maximum time in seconds the script waits for the Docker service to be ready. Default is 300 seconds (5 minutes).
- `zerotier_container`: The name of your ZeroTier container. Change it if your container has a different name from the default.
- `max_checks_zerotier`: The maximum number of checks the script will attempt to confirm the ZeroTier container is running. Default is set to 10 checks.
- `wait_time_zerotier_container`: Time in seconds between each check for the ZeroTier container. Default is set to 30 seconds.

## Installation and Usage
1. **Install the User Scripts Plugin**: If not already installed, add the User Scripts plugin to your Unraid server from the Apps tab.
2. **Create a New Script**:
    - Navigate to the User Scripts page on your Unraid dashboard.
    - Click on `Add new script`.
    - Name your script, e.g., `ZeroTier-Nginx-Fixer`.
    - Copy and paste the entire content of the script into the script editor.
3. **Configure the Script**:
    - Modify the user variables at the top of the script as per your server setup and preferences.
4. **Set Script to Run at Array Start**:
    - In the User Scripts settings for your script, set it to auto-run at 'First Array Start'. This makes sure the script runs automatically every time the server starts.

## License
This script is provided under the MIT License. Feel free to use it and modify it as needed for your Unraid servers.
