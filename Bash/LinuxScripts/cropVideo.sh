#!/bin/bash
ffmpeg -ss "$1" -to "$2" -i "$3" -c copy "$4"
