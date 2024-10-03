#!/bin/bash
gcc "$1" -o "${1%.c}.compiled"
