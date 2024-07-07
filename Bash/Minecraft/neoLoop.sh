!/bin/bash
SCRIPT="start.sh"
WEBHOOK_URL="https://discord.com/api/webhooks/1235569718325415996/U--rQ8VUYOlwDY3WJbj6ecnjWdhyXY-DuQcGJYpQMi0m9s8jkQ7udxVlfk-8NFEpX1s2"
send_message() {
    curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$1\"}" "$WEBHOOK_URL"
}

send_message "[LOP] Server relaunch wrapped started!"
while :
do
  send_message "[LOP] Starting main wrapper..."
  bash $SCRIPT
  send_message "[LOP] Server exited! Restarting..."
done
