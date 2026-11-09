#!/usr/bin/env bash
# Smart dictionary popup: cache -> web API -> offline dictd, with a circuit breaker.
APPID=dictpopup
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/dictpopup"
BREAKER="${XDG_RUNTIME_DIR:-/tmp}/dictpopup.web-down"
BREAKER_TTL=10        # seconds to skip the web after it fails
DICT_HOST=localhost

dim() { printf '\033[2m%s\033[0m\n' "$1"; }

breaker_open() {
  [ -e "$BREAKER" ] && [ $(( $(date +%s) - $(stat -c %Y "$BREAKER") )) -lt "$BREAKER_TTL" ]
}

# rc 0 = JSON on stdout | 1 = web fine, word unknown | 2 = web down/slow/limited
online_lookup() {
  local q out code
  q=$(jq -rn --arg w "$1" '$w|@uri')
  out=$(curl -sS --connect-timeout 2 --max-time 3 -w '\n%{http_code}' \
        "https://api.dictionaryapi.dev/api/v2/entries/en/$q" 2>/dev/null) || return 2
  code=${out##*$'\n'}
  out=${out%$'\n'*}
  case $code in
    200) jq -e 'type=="array"' <<<"$out" >/dev/null 2>&1 || return 2
         printf '%s' "$out" ;;
    404) return 1 ;;
    *)   return 2 ;;
  esac
}

show_json() {   # $1=word  $2=json
  jq -r --arg w "$1" '"\u001b[1;36m\($w)\u001b[0m  " + (.[0].phonetic // "")' <<<"$2"
  jq -r '
    [.[].meanings[]][] |
    "\n\u001b[1;33m\(.partOfSpeech)\u001b[0m",
    ( .definitions[:5] | to_entries[] |
      "  \(.key+1). \(.value.definition)" +
      (if .value.example then "\n     e.g. \(.value.example)" else "" end) )
  ' <<<"$2"
}

stems() {       # the word itself first, then crude de-inflection guesses
  local w=$1 b
  printf '%s\n' "$w"
  [[ $w == *" "* || ${#w} -lt 5 ]] && return
  case $w in
    *ies) printf '%s\n' "${w%ies}y" ;;
    *ing) b=${w%ing}; printf '%s\n' "$b" "${b}e"
          [[ ${b: -1} == "${b: -2:1}" ]] && printf '%s\n' "${b%?}" ;;
    *ed)  b=${w%ed};  printf '%s\n' "$b" "${w%d}"
          [[ ${b: -1} == "${b: -2:1}" ]] && printf '%s\n' "${b%?}" ;;
    *es)  printf '%s\n' "${w%es}" ;;
    *s)   printf '%s\n' "${w%s}" ;;
  esac
}

offline_lookup() {
  command -v dict >/dev/null || return 1
  local base=$1 w db out
  while IFS= read -r w; do
    for db in wn gcide; do
      out=$(timeout 3 dict -h "$DICT_HOST" -d "$db" -- "$w" 2>/dev/null) || continue
      [ -n "$out" ] || continue
      out=$(sed -n '/^From /,$p' <<<"$out" \
            | sed -E 's/^( +)(n|v|adj|adv|s) ([0-9]+:)/\1\x1b[1;33m\2\x1b[0m \3/')
      [ "$w" != "$base" ] && printf 'showing "%s" for "%s"\n\n' "$w" "$base"
      printf '%s\n' "$out"
      return 0
    done
  done < <(stems "$base")
  return 1
}

render() {
  local word=$1 cols key cache resp rc out why="word not in web dictionary"
  cols=$(tput cols 2>/dev/null || echo 80)
  key=${word//[^a-z0-9-]/_}
  cache="$CACHE_DIR/$key.json"

  # 1) cache
  if [ -s "$cache" ]; then
    { show_json "$word" "$(<"$cache")"; echo; dim "source: cache"; } | fold -s -w "$cols"
    return
  fi

  # 2) web (skipped while the circuit breaker is open)
  if breaker_open; then
    why="web unavailable"
  else
    resp=$(online_lookup "$word"); rc=$?
    case $rc in
      0) rm -f "$BREAKER"
         mkdir -p "$CACHE_DIR"; printf '%s' "$resp" > "$cache"
         { show_json "$word" "$resp"; echo; dim "source: online"; } | fold -s -w "$cols"
         return ;;
      2) touch "$BREAKER"; why="web unavailable" ;;
    esac
  fi

  # 3) offline dictd
  if out=$(offline_lookup "$word"); then
    { printf '\033[1;36m%s\033[0m\n' "$word"; printf '%s\n' "$out"; echo
      dim "source: offline ($why)"; } | fold -s -w "$cols"
    return
  fi

  printf '\033[1;31mNo definition found for "%s".\033[0m\n' "$word"
  timeout 2 dict -h "$DICT_HOST" -D >/dev/null 2>&1 \
    || dim "Offline dictionary unreachable. Is dictd running? (systemctl status dictd)"
}

# Selection: XWayland apps (e.g. your Brave/Foliate launches) use the X11
# primary selection; native Wayland apps use the Wayland primary selection.
get_selection() {
  local xw sel=""
  xw=$(hyprctl activewindow -j 2>/dev/null | jq -r '.xwayland // false')
  if [ "$xw" = "true" ] && command -v xclip >/dev/null; then
    sel=$(DISPLAY=:0 timeout 1 xclip -o -selection primary 2>/dev/null)
  fi
  [ -z "$sel" ] && sel=$(timeout 1 wl-paste --primary --no-newline 2>/dev/null)
  printf '%s' "$sel"
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

word=$(get_selection | tr -s '[:space:]' ' ' \
  | sed -E 's/^[[:punct:][:space:]]+|[[:punct:][:space:]]+$//g')
word=${word,,}

if [ -z "$word" ]; then
  notify-send -a Dictionary "Dictionary" "Nothing selected."
  exit 0
fi
if [ "$(wc -w <<<"$word")" -gt 3 ]; then
  notify-send -a Dictionary "Dictionary" \
    $'Select a single word or short phrase.\nGot: '"${word:0:60}"
  exit 0
fi

exec foot --app-id="$APPID" --title="Dictionary" "$0" --render "$word"
