{ config, pkgs, ... }:

{
  imports =
    [
      ../packages/base.nix
      ../services/uefi.nix
      ../services/vpn.nix
      ../services/docker.nix
      ../services/nvidia.nix
    ];

##################
### NETWORKING ###
##################
  networking = {
    useDHCP = false;
    usePredictableInterfaceNames = false;
    interfaces.eth0.wakeOnLan.enable = true;
    interfaces.eth0.ipv4.addresses = [ {
      address = "10.17.10.19";
      prefixLength = 24;
    } ];
    defaultGateway = "10.17.10.1";
    nameservers = [
      "8.8.8.8"
      "8.8.1.1"
    ];
    hostName = "osiris";
  };
  
############
## MOUNTS ##
############
#  fileSystems."/Storage" = {
#    device = "/dev/vg_storage/lv_storage";
#    fsType = "ext4";
#  };

################
### PACKAGES ###
################
  environment.systemPackages = with pkgs; [
    yt-dlp
    ffmpeg
  ];
  
##############
### REBOOT ###
##############
  system.autoUpgrade.allowReboot = true;
  
}
