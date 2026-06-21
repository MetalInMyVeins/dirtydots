#/bin/bash

read pid name usage <<< $(top -b -n 1 | awk 'NR==8 {printf "%s %s %s", $1, $12, $9}')

if [ ${#name} -gt 8 ]; then
  short_name="${name:0:8}+"
else
  short_name="$name"
fi

echo "$short_name $usage%"


