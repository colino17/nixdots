{ config, pkgs, ... }:

#################
### TODO LIST ###
#################
# Remove unwanted gnome apps (ex: gnome-tour)
# Fix etcher/electron dependency issue
# Investigate VFIO config
# Investigate variables
# Add GPRename
# RDP stuff in gnome

################
### IMPORTS ###
################
{
  imports =
    [
      ./hardware-configuration.nix
#      ./devices/pi3.nix
#      ./devices/pi2.nix
#      ./devices/laptop.nix
#      ./devices/dev.nix
#      ./devices/desktop.nix
#      ./devices/server.nix
    ];

#############
### USERS ###
#############
  users.users.colin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

################
### TIMEZONE ###
################
  time.timeZone = "Canada/Atlantic";

###################
### SSH SUPPORT ###
###################
  services.openssh.enable = true;

##################################
### SYSTEM VERSION AND UPDATES ###
##################################
  nix.autoOptimiseStore = true;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };
  system = {
    stateVersion = "21.11";
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
    autoUpgrade.dates = "daily";
  };
}
