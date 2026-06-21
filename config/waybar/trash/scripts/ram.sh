#!/bin/bash

# Get the used memory in MiB
#used_mem=$(free -m | awk '/Mem:/ { print $3 }')

# Convert used memory to GiB
#used_mem_gib=$(echo "scale=2; $used_mem / 1024" | bc)

# Print the output in the required format
#printf "  %.2f GiB  " "$used_mem_gib"

# Get the used memory in MiB
used_mem=$(free -m | awk '/Mem:/ { print $3 }')
~/.config/waybar/scripts/rambin $used_mem


