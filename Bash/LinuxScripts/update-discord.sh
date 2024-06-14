dlUrl="https://dl.discordapp.net/apps/linux/0.0.56/discord-0.0.56.tar.gz"
appDir="/home/tsu/Software" # Hacky fix for structure of Discord archive.
pakName="discord-update-archive.tar.gz"
dlDir="/home/tsu/Downloads"
pakPath="$dlDir/$pakName"

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

removePak() {
    if [ -e "$pakPath" ]; then
        log MAGENTA "Removing archive..."
        rm "$pakPath"
    fi
}

getPak() {
    log MAGENTA "Downloading archive..."
    wget "$dlUrl" -O "$pakPath"
}

extractPak() {
    log MAGENTA "Extracting archive..."
    tar -xvf "$pakPath" --directory="$appDir" --overwrite
}

removePak
getPak
extractPak

log MAGENTA "Done."
