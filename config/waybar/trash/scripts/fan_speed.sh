#!/bin/bash

# This script reads the fan speed from the sensors output

# Adjust the grep and awk commands according to your sensor output
fan_speed=$(sensors | grep 'fan1:' | awk '{print $2}')

# If the fan speed is not found, set it to "N/A"
if [ -z "$fan_speed" ]; then
    fan_speed="N/A"
fi

echo "  $fan_speed rpm  "

