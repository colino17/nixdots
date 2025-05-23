# NIXOS SETUP

Personal NIXOS device setup stack.

## USAGE
This is a personal repo that I use to manage my NixOS Configs for my various devices. 

Device level setup guides can be found in the devices subfolder along with the main configuration files for each of those devices. 

There is also a custom bash script for pulling down updates from this repo. Once the system is bootstrapped there is a bash alias ("get") for doing this.

The repo also relies on a variables.nix file with custom configuration values. There is a sample version that gets copied into the /etc/nixos folder on first setup. It needs to be populated with the appropriate info.

As this is a personal repo it is not particulary useful for others, however it could be forked and used as a framework for your own NixOS setup with the appropriate modifications.

## TODO
- Cosmic Desktop Configuration
  - Exclude Packages
  - Settings
    - Autotile
    - Disable Dock
    - Panel Items
      - Numbered Workspaces | Calendar | Notifications Tray, Tiling, Sound, Network, Power, Bluetooth, Session
    - Accent Color
    - Wallpapers
    - Icons (and apply to Gnome Apps)
    - Shortcuts
      - Firefox Private
      - Discord
    - Window Hint Size
    - Gap Size
    - Remove Maximize and Minimize
    - Focus Follows Cursor
