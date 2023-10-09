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
    
  fileSystems."/Storage/Configs" =
    { device = "/dev/disk/by-label/backup";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Configs" ];
    };

  fileSystems."/Storage/Files" =
    { device = "/dev/disk/by-label/backup";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Files" ];
    };

  fileSystems."/Storage/Media" =
    { device = "/dev/disk/by-label/backup";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Media" ];
    };
  
##########################
### VERSION AND REBOOT ###
##########################
  system = {
    stateVersion = "23.11";
    autoUpgrade.allowReboot = false;
  };
  
}
