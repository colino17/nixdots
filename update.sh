#!/bin/bash

# PULL CONFIGS
wget https://github.com/colino17/nixdots/archive/refs/heads/main.zip
sleep 1

# UNZIP CONFIGS
unzip main.zip
sleep 1

# MOVE CONFIGS TO CURRENT DIRECTORY
rsync -a nixdots-main/* .
sleep 1

# CLEANUP
rm -r nixdots-main
sleep 1
rm main.zip
sleep 1

# REAPPLY PERMISSIONS
chmod +x update.sh
