#!/bin/bash

temp=$(sensors | awk '/CPU:/ { print $2 }')
~/.config/waybar/scripts/tempbin $temp


