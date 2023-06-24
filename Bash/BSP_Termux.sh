#!/data/data/com.termux/files/usr/bin/sh
URL="https://scaleway.testdebit.info/1M/1M.txt"  # URL of a file to download
TIMEOUT=300  # Timeout value in seconds
START_TIME=$(date +%s)
BYTES_DOWNLOADED=$(curl -o /dev/null -w '%{size_download}' -s "$URL" --max-time $TIMEOUT)
END_TIME=$(date +%s)
ELAPSED_TIME=$((END_TIME - START_TIME))
DOWNLOAD_SPEED_B=$(bc <<< "scale=2; $BYTES_DOWNLOADED / $ELAPSED_TIME")
DOWNLOAD_SPEED_KB=$(bc <<< "scale=2; $DOWNLOAD_SPEED_B / 1024")
DOWNLOAD_SPEED_MB=$(awk -v speed="$DOWNLOAD_SPEED_KB" 'BEGIN { printf "%.2f", speed / 1024 }')
echo "INI: $START_TIME"
echo "END: $END_TIME"
echo "SEC: $ELAPSED_TIME"
echo "BytesDLd: $BYTES_DOWNLOADED"
echo
echo "Download Speed:"
echo "$DOWNLOAD_SPEED_B B/s"
echo "$DOWNLOAD_SPEED_KB KB/s"
echo "$DOWNLOAD_SPEED_MB MB/s"
echo
echo "$START_TIME;$END_TIME;$ELAPSED_TIME;$BYTES_DOWNLOADED;$DOWNLOAD_SPEED_B;$DOWNLOAD_SPEED_KB;$DOWNLOAD_SPEED_MB" >> BST.data