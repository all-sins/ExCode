SCREEN_SESSION_NAME="ftb-managed-server"
NEOSTART_SCRIPT="neoLoop.sh"
START_SCRIPT="start.sh"

is_screen_session_exists() {
    screen -list | grep -q "$SCREEN_SESSION_NAME"
}

exit_screen() {
    screen -S "$SCREEN_SESSION_NAME" -X quit
}

get_pid() {
    PID=$(pgrep -f "$1")
    echo "$PID"
}

# ANSI color escape codes.
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m' # No Color (reset)

send_message() {
    local color=$1
    local msg=$2
    echo -e "${!color}$msg${NC}"
}

kill_server() {
    send_message YELLOW "[CRS] Attempting to locate loop wrapper..."
    PID=$(get_pid $START_SCRIPT)
    if [ -z "$PID" ]; then
        send_message GREEN "[N/A] Loop wraper doesn't exist!"
    else
        send_message CYAN "[CRS] Found!"
        send_message CYAN "[CRS] Pulling out the choppa..."
        kill -9 "$PID"
        send_message GREEN "[CRS] Done."
    fi

    send_message YELLOW "[CRS] Attempting to locate starter wrapper..."
    PID=$(get_pid $NEOSTART_SCRIPT)
    if [ -z "$PID" ]; then
        send_message GREEN "[N/A] Loop wraper doesn't exist!"
    else
        send_message CYAN "[CRS] Found!"
        send_message CYAN "[CRS] Pulling out the choppa..."
        kill -9 "$PID"
        send_message GREEN "[CRS] Done."
    fi
}

kill_server
if is_screen_session_exists; then
    exit_screen
fi
