{ config, pkgs, ... }:

# https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi_3
## Write image to SD Card (and USB drive??)
## 
# Use aarch64 image for Raspberry Pi 3 - https://hydra.nixos.org/job/nixos/release-21.11/nixos.sd_image.aarch64-linux
# Tailscale subnets - https://tailscale.com/kb/1019/subnets/
### "sudo tailscale up --advertise-routes=10.0.0.0/24,10.0.1.0/24" on router
### "sudo tailscale up --accept-routes" on specific Linux clients

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
      core_freq=250
      program_usb_boot_mode=1
    '';
  };
  
##################
### FILESYSTEM ###
##################
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
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
    libraspberrypi
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
