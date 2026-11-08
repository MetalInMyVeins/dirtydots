#!/usr/bin/env bash
# Toggleable dictionary popup for the selected text.
APPID=dictpopup

render() {
  local word=$1 q resp cols
  cols=$(tput cols 2>/dev/null || echo 80)
  q=$(jq -rn --arg w "$word" '$w|@uri')
  resp=$(curl -fsS --max-time 5 "https://api.dictionaryapi.dev/api/v2/entries/en/$q" 2>/dev/null)

  if [ -n "$resp" ] && jq -e 'type=="array"' <<<"$resp" >/dev/null 2>&1; then
    {
      jq -r --arg w "$word" '"\u001b[1;36m\($w)\u001b[0m  " + (.[0].phonetic // "")' <<<"$resp"
      jq -r '
        [.[].meanings[]][] |
        "\n\u001b[1;33m\(.partOfSpeech)\u001b[0m",
        ( .definitions[:5] | to_entries[] |
          "  \(.key+1). \(.value.definition)" +
          (if .value.example then "\n     e.g. \(.value.example)" else "" end) )
      ' <<<"$resp"
    } | fold -s -w "$cols"
  elif command -v wn >/dev/null && wn "$word" -over >/dev/null 2>&1; then
    wn "$word" -over | grep -vE '^(The (noun|verb|adj|adv)|$)'
  else
    printf '\033[1;31mNo definition found for "%s" (or you are offline).\033[0m\n' "$word"
  fi
}

# Mode 2: runs inside the popup
if [ "$1" = "--render" ]; then
  render "$2" | less -R
  exit 0
fi

# Mode 1: keybind entry point. If the popup is open, close it (toggle off).
if pgrep -f -- "--app-id=$APPID" >/dev/null; then
  pkill -f -- "--app-id=$APPID"
  exit 0
fi

# Grab the selection BEFORE opening the popup (primary, then clipboard)
word=$(wl-paste --primary --no-newline 2>/dev/null)
[ -z "$word" ] && word=$(wl-paste --no-newline 2>/dev/null)
word=$(printf '%s' "$word" | tr -s '[:space:]' ' ' \
  | sed -E 's/^[[:punct:][:space:]]+|[[:punct:][:space:]]+$//g')
word=${word,,}

if [ -z "$word" ]; then
  notify-send -a Dictionary "Dictionary" "Nothing selected."
  exit 0
fi
if [ "$(wc -w <<<"$word")" -gt 3 ]; then
  notify-send -a Dictionary "Dictionary" "Select a single word or short phrase."
  exit 0
fi

exec foot --app-id="$APPID" --title="Dictionary" "$0" --render "$word"
