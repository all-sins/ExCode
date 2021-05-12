#!/bin/bash

# Define filename in a variable and init fileContents.
file="lastbak.date"
fileContents=""

#Reading contents of file.
while read lineString; do
	fileContents+=${lineString}
done < $file

echo "Read following value from file: ${fileContents}"

# Check if enough time has passed.
currentDateInSec=`date +%s`
hourAheadDate=$(( $fileContents + 3600 ))
if (($hourAheadDate < $currentDateInSec)); then
	echo "Running backup..."
else
	echo "Sleeping..."
fi