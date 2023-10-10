{ config, pkgs, ... }:

{
  imports =
    [
      ../services/base.nix
      ../services/uefi.nix
      ../services/btrfs.nix
      ../users/colin.nix
    ];

##################
### NETWORKING ###
##################
  networking = {
    hostName = "khonsu";
    interfaces.enp1s0 = {
      wakeOnLan.enable = true;
      ipv4.addresses = [ {
        address = "10.17.10.19";
        prefixLength = 24;
      } ];
    };
    defaultGateway = "10.17.10.1";
    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];
  };

############
## MOUNTS ##
############
  fileSystems."/" =
    { fsType = "btrfs";
      options = [ "compress=zstd" "subvol=root" ];
    };
    
  fileSystems."/Backup" =
    { device = "/dev/disk/by-label/backup";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Backup" ];
    };

################
## NFS MOUNTS ##
################

  fileSystems."/Storage" = {
    device = "10.17.10.17:/Snapshots";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.mount-timeout=10" "timeo=14" "x-systemd.idle-timeout=60min" ];
  };
  
##########################
### VERSION AND REBOOT ###
##########################
  system = {
    stateVersion = "23.05";
    autoUpgrade.allowReboot = false;
  };
  
}
