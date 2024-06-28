#!/bin/bash

# Define the command to launch your script
SCRIPT="neoStart.sh"

# Define the duration to sleep (in seconds) before relaunching the script
SLEEP_DURATION=5

# Infinite loop
while :
do
  # Launch the script
  echo "Launcing server..."
  ./"$SCRIPT"

  # Sleep for the specified duration
  echo "Server exited. Sleeping for $SLEEP_DURATION seconds before relaunching..."
  sleep "$SLEEP_DURATION"
done

