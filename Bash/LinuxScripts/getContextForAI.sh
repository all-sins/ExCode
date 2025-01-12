#!/bin/bash
rm test/*
cp *.c test/
cp *.h test/
cd test/
for file in *; do echo "Filename: $file"; cat "$file"; echo; done | xclip -selection clipboard
cd ..