#!/bin/bash

#network=$(~/.config/waybar/bin/network.sh)
#if [ $network -eq "0" ]
#then
#  echo "⚠"
#else
#  city=$(curl -s https://ipinfo.io/city)
#  # Fetch the weather information
#  weather=$(curl -s "wttr.in/${city}?format=%C+%t")

#  # Extract and print the cloud status and temperature
#  cloud_status=$(echo "$weather" | awk '{print $1}')
#  temperature=$(echo "$weather" | awk '{print $2}')

#  echo "$cloud_status $temperature"
#fi

#network=$(~/.config/waybar/bin/network.sh)
#if [ $network -eq "0" ]
#then
  #echo "⚠"
  #echo "🚫"
#  echo "failed"
#  exit 0
#else
#  city=$(curl -s https://ipinfo.io/city)
#  CITY=${1:-"$city"}

  # Fetch the weather information
#  WEATHER=$(curl -s "wttr.in/${CITY}?format=%C+%t")

  # Extract and print the cloud status and temperature
#  CLOUD_STATUS=$(echo "$WEATHER" | awk '{print $1}')
#  TEMPERATURE=$(echo "$WEATHER" | awk '{print $2}')

#  echo "$CLOUD_STATUS $TEMPERATURE"
#fi


network=$(~/.config/waybar/bin/network.sh)
if [ $network -eq "0" ]
then
  #echo "⚠"
  #echo "🚫"
  echo "failed"
  exit 0
else
  city=$(curl -s https://ipinfo.io/city)
  CITY=${1:-"$city"}
  #CITY="Sylhet"
  CITY=""

  # Fetch the weather information
  WEATHER=$(curl -s "wttr.in/${CITY}?format=%C+%t")

  # Extract and print the cloud status and temperature
  CLOUD_STATUS=$(echo "$WEATHER" | awk '{print $1}')
  TEMPERATURE=$(echo "$WEATHER" | awk '{print $2}')

  echo "$CLOUD_STATUS $TEMPERATURE"
fi

