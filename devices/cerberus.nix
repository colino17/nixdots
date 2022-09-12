{ config, pkgs, ... }:

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
      address = "10.17.10.33";
      prefixLength = 24;
    } ];
    defaultGateway = "10.17.10.1";
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
    hostName = "cerberus";
    firewall = {
      allowedTCPPorts = [ 53 80 ];
      allowedUDPPorts = [ 53 ];
    };
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

##############
### REBOOT ###
##############
  system.autoUpgrade.allowReboot = true;

}
