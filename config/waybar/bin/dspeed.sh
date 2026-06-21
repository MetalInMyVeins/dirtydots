#!/bin/bash

# Define the network interface (e.g., eth0, wlan0)
INTERFACE="wlp4s0"

# Get initial download bytes
initial_rx_bytes=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
sleep 1
new_rx_bytes=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)

~/.config/waybar/bin/dspeedbin $initial_rx_bytes $new_rx_bytes
exit 0



