#!/bin/bash

# Define the network interface (e.g., eth0, wlan0)
INTERFACE="wlp4s0"

# Get initial download bytes
initial_rx_bytes=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)

# Sleep for 1 second
sleep 1

# Get new download bytes
new_rx_bytes=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)

# Calculate the download speed in bytes per second
download_speed=$(($new_rx_bytes - $initial_rx_bytes))

# Convert and format the download speed
if [ $download_speed -lt 1024 ]; then
    speed="${download_speed} B/s"
elif [ $download_speed -lt 1048576 ]; then
    speed=$(echo "scale=2; $download_speed / 1024" | bc)
    speed="${speed} KiB/s"
elif [ $download_speed -lt 1073741824 ]; then
    speed=$(echo "scale=2; $download_speed / 1048576" | bc)
    speed="${speed} MiB/s"
else
    speed=$(echo "scale=2; $download_speed / 1073741824" | bc)
    speed="${speed} GiB/s"
fi

# Print the output
echo "  ⬇ $speed  "


