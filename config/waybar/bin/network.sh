#!/bin/bash

# Test internet connection by pinging a reliable server
if ping -c 1 -W 2 8.8.8.8 &> /dev/null; then
  echo "1"
else
  echo "0"
fi

