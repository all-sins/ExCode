#!/bin/bash
# ANSI color escape codes.
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m' # No Color (reset)

log() {
	local color=$1
	local msg=$2
	echo -e "${!color}$msg${NC}"
}

if [[ -z "$1" ]]; then
	log RED "[ERROR] CLI args absent!"
	exit 2
fi

if ls "${1%.c}.compiled" 1> /dev/null 2>&1; then
	rm "${1%.c}.compiled"
fi

gcc "$1" -o "${1%.c}.compiled"

if [[ ! -z $2 ]]; then
	./"${1%.c}.compiled"
fi
