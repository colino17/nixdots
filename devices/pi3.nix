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
      ../packages/base.nix
      ../services/vpn.nix
    ];

##################
### BOOTLOADER ###
##################
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = 1;


##################
### NETWORKING ###
##################
  networking = {
    useDHCP = false;
    usePredictableInterfaceNames = false;
    interfaces.eth0.ipv4.addresses = [ {
      address = "192.168.0.33";
      prefixLength = 24;
    } ];
    defaultGateway = "192.168.0.1";
    nameservers = [
      "8.8.8.8"
      "8.8.1.1"
    ];
    hostName = "cerberus";
  };

###############
### ADGUARD ###
###############
  services.adguardhome = {
    enable = true;
    openFirewall = true;
  };  

################
### PACKAGES ###
################
  environment.systemPackages = with pkgs; [
    libraspberrypi
  ];
  
}
