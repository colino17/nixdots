# NIXOS SETUP

Personal NIXOS device setup stack.

## TODO
- Fix Gnome Tiling and Hotkeys
- Create .apps and .scripts folders
- Pull down apps and scripts
- Investigate universal config variables (wallpaper, neofetch, stateversion)
- Split homes

# How to use

1. Boot into a NixOS installer.
1. At the shell prompt, type `sudo su` to switch to a root shell.
1. Temporarily install git by typing `nix-shell -p git`.
1. Partition the disks.
1. Once `/mnt` is mounted, type `git clone -b main https://github.com/colino17/nixdots.git /mnt/etc/nixos` or whatever repo/branch you need.
1. Type `nixos-generate-config --root /mnt`, it will not overwrite the configuration.nix and only makes the hardware-configuration.nix.
1. Edit the configuration.nix if needed.
1. Change directory and install, type `cd /mnt` and `nixos-install`.
1. Set the root password for the system.
1. Reboot the system.
