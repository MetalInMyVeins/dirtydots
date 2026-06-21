#!/bin/bash

# Get the used memory in MiB
used_mem=$(free -m | awk '/Mem:/ { print $3 }')
total_mem=$(free -m | awk '/Mem:/ { print $2 }')

perc=$(echo "$used_mem * 100 / $total_mem" | bc)
echo "  $perc% 🎟  "

