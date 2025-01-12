#!/bin/bash
ENV_SCRIPT="envSet.sh"
source $ENV_SCRIPT
SCRIPT="start.sh"
WEBHOOK_URL="$DISCORD_WEBHOOK_URL"
send_message() {
    curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$1\"}" "$WEBHOOK_URL"
}

send_message "[LOP] Server relaunch wrapped started!"
while :
do
  send_message "[LOP] Starting main wrapper..."
  bash $SCRIPT
  sleep 5
  send_message "[LOP] Server exited! Restarting..."
done
