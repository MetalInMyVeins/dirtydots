#!/bin/bash

input="colors.sh"
output="colors.fish"

# Start clean
echo "# Fish variables (converted from colors.sh)" > "$output"

while IFS= read -r line; do
    # Skip comments and blank lines
    [[ "$line" =~ ^#.*$ || -z "$line" ]] && echo "$line" >> "$output" && continue

    # Convert 'var=value' to 'set -gx var value'
    if [[ "$line" =~ ^([a-zA-Z0-9_]+)=[\'\"]?([^\'\"]+)[\'\"]?$ ]]; then
        var="${BASH_REMATCH[1]}"
        val="${BASH_REMATCH[2]}"
        echo "set -gx $var \"$val\"" >> "$output"
    else
        # Convert export lines to 'set -gx' lines
        if [[ "$line" =~ ^export[[:space:]]+([a-zA-Z0-9_]+)=\"(.*)\"$ ]]; then
            var="${BASH_REMATCH[1]}"
            val="${BASH_REMATCH[2]}"
            echo "set -gx $var \"$val\"" >> "$output"
        else
            # Pass through any other line unchanged
            echo "# Unparsed: $line" >> "$output"
        fi
    fi
done < "$input"

echo "Converted to $output"
