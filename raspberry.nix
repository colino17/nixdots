{ config, pkgs, ... }:

################
### IMPORTS ###
################
{
  imports =
    [
      ./hardware-configuration.nix
    ];

#########################
### BOOTLOADER - BIOS ###
#########################
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

#########################
### BOOTLOADER - UEFI ###
#########################
#  boot.loader.systemd-boot = {
#    enable = true;
#    configurationLimit = 3;
#    editor = false;
#  };

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

##################
### NETWORKING ###
##################
  networking = {
    useDHCP = false;
    interfaces.enp12s0.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
    hostName = "pivpn";
  };
  
###########
### VPN ###
###########
  services.tailscale = { enable = true; };

################
### PACKAGES ###
################
  nixpkgs.config.allowUnfree = false;
  documentation.nixos.enable = false;
  environment.systemPackages = with pkgs; [
    wget
    curl
    tailscale
  ];

###################
### SSH SUPPORT ###
###################
  services.openssh.enable = true;

##################################
### SYSTEM VERSION AND UPDATES ###
##################################
  system = {
    stateVersion = "21.11";
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
  };
}
