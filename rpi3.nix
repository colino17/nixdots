{ config, pkgs, ... }:

# Use aarch64 image for Raspberry Pi 3


################
### IMPORTS ###
################
{
  imports =
    [
      ./hardware-configuration.nix
    ];

##################
### BOOTLOADER ###
##################
  boot.kernelPackages = pkgs.linuxPackages_rpi;
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = false;
  boot.loader.raspberryPi = {
    enable = true;
    version = 3;
    firmwareConfig = ''
      disable_splash=1
    '';
  };

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
    usePredictableInterfaceNames = false;
    interfaces.eth0.ipv4.addresses = [ {
      address = "192.168.0.22";
      prefixLength = 24;
    } ];
    defaultGateway = "192.168.0.1";
    nameservers = [
      "8.8.8.8"
      "8.8.1.1"
    ];
    hostName = "pivpn";
  };
  
###########
### VPN ###
###########
  services.tailscale = { enable = true; };

###############
### ADGUARD ###
###############
  services.adguardhome = {
    enable = true;
  };  

################
### PACKAGES ###
################
  nixpkgs.config.allowUnfree = false;
  documentation.nixos.enable = false;
  environment.systemPackages = with pkgs; [
    wget
    curl
  ];
  
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
