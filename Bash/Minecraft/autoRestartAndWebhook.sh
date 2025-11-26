
SCREEN_SESSION_NAME="mce-managed-server"
NEOSTART_SCRIPT="neoStart.sh"
WEBHOOK_URL=""
MESSAGE="Placeholder..."
RESTART_INTERVAL="720 minutes"
RESTART_INTERVAL_SLEEP_COMMAND_APPEASER="720m" # Same value as above, but different format so that sleep command doesn't complain.

# Function to send message to Discord webhook
send_message() {
    curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$1\"}" "$WEBHOOK_URL"
}

# Function to check if screen session exists
is_screen_session_exists() {
    screen -list | grep -q "$SCREEN_SESSION_NAME"
}

exit_screen() {
    screen -S "$SCREEN_SESSION_NAME" -X quit
}

kill_server() {
    send_message "[CRS] Attempting to locate process..."
    $PID=$(get_server_pid)
    if [ -z "$PID" ]; then
        send_message "[ERR] The server process was not found! Contact @og.tsu"
    else
        send_message "[CRS] Server process found!"
	send_message "[CRS] Pulling out the choppa..."
	kill -9 "$PID"
	send_message "[CRS] Successfully unalive'd!"
    fi
}

get_server_pid() {
    PID=$(pgrep -f "$NEOSTART_SCRIPT")
    echo "$PID"
}

get_spark_profiler_url() {
    SPARK_URL=$(grep -oP "https:\/\/spark\.lucko\.me\/\w+(?=[\n\r]|$)" /logs/latest.log)
    echo "$SPARK_URL"
}

print_spark_profiler_url() {
    send_message "[SPK] Searching for profiler result..."
    SPARK_URL=$(get_spark_profiler_url)
    if [ -z "$SPARK_URL" ]; then
        send_message "[SPK] Not found! Assuming profiler wasn't run..."
    else
	send_message "[SPK] Found: $SPARK_URL"
    fi
}

if is_screen_session_exists; then
    exit_screen
fi

# Function to restart Minecraft server
restart_minecraft_server() {
    # Get the PID of neoStart.sh
    NEOSTART_PID=$(pgrep -f "$NEOSTART_SCRIPT")

    if [ -n "$NEOSTART_PID" ]; then
        # Stop Minecraft server
	send_message "[SPK] Stopping profiler..."
        screen -S "$SCREEN_SESSION_NAME" -X stuff "/spark profiler --stop^M"
	sleep 30s

	send_message "[SRV] Gracefully shutting down existing server..."
	screen -S "$SCREEN_SESSION_NAME" -X stuff "stop^M"

        # Wait for the server to shut down gracefully
	SNOOZE=1
	ASSUME_CRASH=0
        while kill -0 "$NEOSTART_PID" >/dev/null 2>&1; do
            if [ $ASSUME_CRASH -le 10 ]; then
	        send_message "[SRV] Waiting for shutdown to finish..."
                sleep "$SNOOZE"
	        SNOOZE=$((SNOOZE * 2))
	        ASSUME_CRASH=$((SNOOZE + 1))
	    else
	        send_message "[WRN] Server unresponsive!"
                kill_server
	    fi
        done
    fi

    # Start Minecraft server
    send_message "[SRV] Starting new server..."
    screen -S "$SCREEN_SESSION_NAME" -X stuff "bash $NEOSTART_SCRIPT^M"

    # For now crude wait. Later implement monitoring of log file for keywords.
    sleep 12m

    # Start profiler
    send_message "[SPK] Starting profiler..."
    screen -S "$SCREEN_SESSION_NAME" -X stuff "/spark profiler --only-over 100^M"
}

# Main loop
while true; do
    # Check if screen session exists
    if ! is_screen_session_exists; then
        # Create screen session if it doesn't exist
	send_message "[SCR] Session didn't exist!"
	send_message "[SCR] Creating..."
        screen -S "$SCREEN_SESSION_NAME" -d -m
	send_message "[SCR] DONE."
    fi

    # Restart Minecraft server
    restart_minecraft_server

    # Find and print profiler URL.
    print_spark_profiler_url

    # Calculate the timestamp for the next restart
    NEXT_RESTART_TIMESTAMP=$(date -d "+$RESTART_INTERVAL" +%s)

    # Convert the timestamp to a human-readable format
    NEXT_RESTART_DATETIME=$(date -d "@$NEXT_RESTART_TIMESTAMP" "+%Y-%m-%d %H:%M:%S")

    # Display and sleep for the calculated duration
    send_message "[SLP] Next restart will occur at: $NEXT_RESTART_DATETIME"
    sleep "$RESTART_INTERVAL_SLEEP_COMMAND_APPEASER"
done


