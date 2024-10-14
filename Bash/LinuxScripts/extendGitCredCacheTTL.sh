#!/bin/bash
git config --global credential.helper cache
git config --global credential.helper "cache --timeout=86400"
