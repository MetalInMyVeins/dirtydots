#!/bin/bash

#string="  🎜  🎵"
#string="  ♪  "
string="  ♫  "
mstatus=$(playerctl status)
if [[ -z "$mstatus" ]]; then
  echo "$string"
  exit 0
fi

string+=" "

# Get the currently playing media details
artist=$(playerctl metadata artist)
if [[ -n "$artist" ]]; then
  short_artist="${artist:0:10}...."
fi

title=$(playerctl metadata title)
if [[ -n "$title" ]]; then
  short_title="${title:0:17}...."
fi

if [[ -n "$short_artist" && -n "$short_title" ]]; then
  string+=" $short_artist" + " - " + "$short_title"
elif [[ -z "$short_artist" && -n "$short_title" ]]; then
  string+=" $short_title"
elif [[ -n "$short_artist" && -z "$short_title" ]]; then
  string+=" $short_artist"
fi

echo "$string  "

#🎜
# If no media is playing, set the output to "No media playing"
#if [ -z "$artist" ] && [ -z "$title" ]; then
#    echo ""
#else
    # Trim the title to the first 10 characters
#    short_title="${title:0:10}..."
    #echo "$artist - $short_title"
#    echo "$short_title"
#fi


