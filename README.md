# Network Traffic Collection Script

This script collects network traffic statistics using the `sar` command, logs the data to a file, and provides a simple and automated way to monitor network usage. It records network traffic statistics every 1 second for 25 iterations and saves the output to a log file for later review.

The script ensures that necessary tools are installed, directories exist, and proper permissions are granted before starting the data collection.

## Prerequisites

- The script requires the `sar` command, which is part of the `sysstat` package.
- `sudo` permissions are required to run the `sar` command.
- The script is intended to run on Linux-based systems.

### Installing `sar`

If the `sar` command is not installed, you can install it using the following command:

- **Linux**:

  ```bash
  sudo apt install sysstat

Usage

    Make the script executable:

    Make sure the script is executable by running the following command:

chmod +x network_traffic_collect.sh

Run the script:

Execute the script by running:

./network_traffic_collect.sh

Script Behavior:

    The script first checks if the sar command is available on your system. If it's not, it provides instructions on how to install it.
    It then checks if the target directory for logs exists, creating it if necessary. The default directory is ~/local/log.
    The script ensures that the user has sudo permissions to execute the sar command.
    The script collects network traffic statistics using sar -n DEV 1 25, which samples network device statistics every 1 second for 25 iterations.
    The collected data is saved to a log file at ~/local/log/sarnetwork.log.
    The log file is appended with timestamps to help identify when each session starts.

Log Output:

After the script runs, the network traffic data will be saved in the log file:

    ~/local/log/sarnetwork.log

    You can review this file to analyze network traffic.

Example Output

After running the script, the log file will contain output similar to the following:

[12-01-2025 14:23:45] Starting network traffic collection...
Linux 5.4.0-80-generic (hostname)  12/01/2025  _x86_64_    (4 CPU)

08:00:01  eth0    0.00      0.00     0.00      0.00
08:00:02  eth0    0.00      0.00     0.00      0.00
...
08:00:25  eth0    0.00      0.00     0.00      0.00

Network traffic inspection completed. Check the log file at: ~/local/log/sarnetwork.log

Script Details

    Dependencies:
        sar (from the sysstat package) for network traffic collection.
        sudo permissions to execute the sar command with root privileges.

    Log Directory: The script logs the data to a directory specified in the LOG_DIR variable (default: ~/local/log).

    Data Collection: The script runs the sar command to collect network traffic statistics for 25 iterations with 1-second intervals. It logs the data in the file sarnetwork.log.

    Log File: The log file includes timestamps for each data collection session, making it easier to correlate network traffic data with specific times.

    Cleanup: After the script finishes, it optionally cleans up any temporary files. The cleanup function removes the log file if you choose to activate it by uncommenting the cleanup line.

Optional Configuration

    You can modify the number of iterations or the sampling interval by changing the parameters in the sar -n DEV 1 25 command. For example:
        sar -n DEV 1 50 will collect data every second for 50 iterations.
        sar -n DEV 2 25 will collect data every 2 seconds for 25 iterations.

    If you want to keep the log file after the script finishes, you can uncomment the line that saves the log file path at the end of the script.

Troubleshooting

    sar Command Not Found: If sar is not installed, you can install the sysstat package using sudo apt install sysstat on Ubuntu/Debian-based systems or the equivalent package manager on your distribution.

    Permissions Issues: The script checks for sudo permissions before running the sar command. If you encounter any permissions issues, ensure that you have the necessary sudo privileges to execute the command.

License

This script is provided as-is. You are free to modify and distribute it under your own terms.


### Key Features of the `README.md`:

- **Installation Instructions**: Provides clear steps to install the necessary dependencies (`sysstat` for `sar`).
- **Usage Instructions**: Outlines how to make the script executable and run it.
- **Log File Location**: Details where the network traffic logs will be saved and how to review them.
- **Customizable Parameters**: Suggests how to change the number of iterations and the interval for the `sar` command.
- **Troubleshooting**: Provides guidance on how to address common issues like missing dependencies or permissions.

Feel free to adjust any details based on your environment or needs.
