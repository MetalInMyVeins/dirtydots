#!/usr/bin/env bash
# ~/.config/goimapnotify/notify-new-mail.sh
# Usage: notify-new-mail.sh <account-label>

ACCOUNT="$1"

case "$ACCOUNT" in
  hossainmdfahim66)
    IMAP_HOST="imap.gmail.com"
    IMAP_USER="hossainmdfahim66@gmail.com"
    IMAP_PASS_CMD="cat ~/.creds/goimapnotify-hossainmdfahim66 | head -n1"
    ;;
  hossainmdfahim0x3c)
    IMAP_HOST="imap.gmail.com"
    IMAP_USER="hossainmdfahim0x3c@gmail.com"
    IMAP_PASS_CMD="cat ~/.creds/goimapnotify-hossainmdfahim0x3c | head -n1"
    ;;
  *)
    exit 1
    ;;
esac

PASS="$(eval "$IMAP_PASS_CMD")"

LATEST_UID=$(curl -s --url "imaps://${IMAP_HOST}/INBOX" \
  --user "${IMAP_USER}:${PASS}" \
  -X 'UID SEARCH ALL' | grep -oE '[0-9]+' | tail -1)

if [ -z "$LATEST_UID" ]; then
  exit 0
fi

MSG=$(curl -s --url "imaps://${IMAP_HOST}/INBOX;UID=${LATEST_UID}" \
  --user "${IMAP_USER}:${PASS}")

FROM=$(echo "$MSG" | grep -i '^From:' | head -1 | sed 's/^From: *//')
SUBJECT=$(echo "$MSG" | grep -i '^Subject:' | head -1 | sed 's/^Subject: *//')

notify-send "[$ACCOUNT]" \
"From: $FROM
Subject: $SUBJECT"
