#!/usr/bin/env bash
# Look up the selected text and show the definition as a notification.

notify() { notify-send -a Dictionary -t 20000 \
  -h string:x-canonical-private-synchronous:dict "$1" "$2"; }

# 1. Selection (primary), falling back to the clipboard
word=$(wl-paste --primary --no-newline 2>/dev/null)
[ -z "$word" ] && word=$(wl-paste --no-newline 2>/dev/null)

# Clean: collapse whitespace, strip edge punctuation, lowercase
word=$(printf '%s' "$word" | tr -s '[:space:]' ' ' \
  | sed -E 's/^[[:punct:][:space:]]+|[[:punct:][:space:]]+$//g')
word=${word,,}

[ -z "$word" ] && { notify "Dictionary" "Nothing selected."; exit 0; }
[ "$(wc -w <<<"$word")" -gt 3 ] && { notify "Dictionary" "Select a single word or short phrase."; exit 0; }

# 2. Lookup (free API, no key)
q=$(jq -rn --arg w "$word" '$w|@uri')
resp=$(curl -fsS --max-time 5 "https://api.dictionaryapi.dev/api/v2/entries/en/$q" 2>/dev/null)

if [ -n "$resp" ] && jq -e 'type=="array"' >/dev/null 2>&1 <<<"$resp"; then
  # 3. Format: up to 3 meanings per part of speech, markup-escaped
  title=$(jq -r --arg w "$word" \
    '"📖 " + $w + (if .[0].phonetic then "  " + .[0].phonetic else "" end)' <<<"$resp")
  body=$(jq -r '
    def esc: gsub("&";"&amp;") | gsub("<";"&lt;") | gsub(">";"&gt;");
    [.[].meanings[]][:6][]
    | "<b>" + (.partOfSpeech|esc) + "</b>\n"
      + ([.definitions[:3][] | "• " + (.definition|esc)] | join("\n"))
  ' <<<"$resp" | paste -sd'\n' | sed 's/^<b>/\n<b>/' | sed '1{/^$/d}')
elif command -v wn >/dev/null && wn "$word" -over >/dev/null 2>&1; then
  # Offline fallback: WordNet
  title="📖 $word"
  body=$(wn "$word" -over | grep -vE '^(The (noun|verb|adj|adv)|$)' | head -n 25 \
    | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')
else
  notify "📖 $word" "No definition found (or you're offline)."
  exit 0
fi

# 4. Notify
notify "$title" "$body"
