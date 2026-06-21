#!/bin/bash

text=""
bluez=""

#if bluetoothctl devices Connected | grep -i -E "headset|audio"; then
if bluetoothctl devices Connected | grep -q .; then
  bluez=" "
else
  bluez=""
fi

volume=$(amixer get Master | grep -oP '\d+%' | head -1)
mute=$(amixer get Master | grep -oP '\[(on|off)\]' | grep -oP '(on|off)' | head -1)

if [[ "$mute" == "on" ]]; then
  mutenonmute=""
elif [[ "$mute" == "off" ]]; then
  mutenonmute="🔇"
fi

micmute=$(amixer get Capture | grep -oP '\[(on|off)\]' | grep -oP '(on|off)' | head -1)

if [[ "$micmute" == "on" ]]; then
  micmutenonmute=""
elif [[ "$micmute" == "off" ]]; then
  micmutenonmute=""
fi

text+="$volume $bluez$mutenonmute $micmutenonmute"
echo "$text"

#mic volume
#amixer get Capture | grep -oP '\d+%' | head -1
#🔇

