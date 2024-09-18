#!/bin/bash

# A small script which can be placed in /etc/nixos and when executed it will pull configs, wallpapers, dots, etc from Github.
# It uses rsync instead of mv so it is able to overwrite and update full directories
# Possibly add an if else condition so that it uses mv on first run if rsync is not available
# This is an alternative to git clone that avoids some of the pitfalls of that tool such as overwriting non-empty directories

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

# CREATE VARIABLES FILE IF IT DOESN'T EXIST
if [ -f "variables.nix" ]; then
  read -p "VARIABLES file already exists. Would you like to overwrite? (yes/no) " yn
  case $yn in 
  	yes ) cp defaults/variables.nix variables.nix;
	  	break;;
  	no ) echo "Custom VARIABLES have been retained.";
	  	break;;
  esac
else
  echo "No VARIABLES found. Creating default VARIABLES file."
  cp defaults/variables.nix variables.nix
fi

# REAPPLY PERMISSIONS
chmod +x update.sh
