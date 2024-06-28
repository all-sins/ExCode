#!/bin/bash

file="logs/latest.log"
#specific_line="\[Server\ thread\/INFO\]\ \[FML\]\:\ Unloading\ dimension"
specific_line="Server\ tick\ complete!"

# Wait until the specific line of text appears in the file
until tail -n 0 -F "$file" | grep -q "$specific_line"; do
    inotifywait -qqt 1 -e modify "$file"
done

# Continue executing the rest of the script
echo "The specific line of text has been found. Continuing with the script..."

