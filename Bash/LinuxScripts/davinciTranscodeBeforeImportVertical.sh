#!/bin/bash
ffmpeg -i $1 -vcodec dnxhd -acodec pcm_s16le -b:v 36M -pix_fmt yuv422p -f mov -map 0:v:0 -map 0:a:0 $2.mov
