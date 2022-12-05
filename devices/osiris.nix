{ config, pkgs, ... }:

{
  imports =
    [
      ../packages/base.nix
      ../services/uefi.nix
      ../services/vpn.nix
      ../services/docker.nix
      ../services/nvidia.nix
      ../services/btrfs.nix
      ../users/colin.nix
    ];

##################
### NETWORKING ###
##################
  networking = {
    useDHCP = false;
    usePredictableInterfaceNames = false;
    interfaces.eth0.wakeOnLan.enable = true;
    interfaces.eth0.ipv4.addresses = [ {
      address = "10.17.80.19";
      prefixLength = 24;
    } ];
    defaultGateway = "10.17.80.1";
    nameservers = [
      "8.8.8.8"
      "8.8.1.1"
    ];
    hostName = "osiris";
  };
  
############
## MOUNTS ##
############
  fileSystems."/Storage/Configs" =
    { device = "/dev/nvme0n1p2";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Configs" ];
    };

  fileSystems."/Storage/Files" =
    { device = "/dev/sdb";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Files" ];
    };

  fileSystems."/Storage/Media" =
    { device = "/dev/sdb";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Media" ];
    };

  fileSystems."/Storage/Recordings" =
    { device = "/dev/sdb";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Recordings" ];
    };

  fileSystems."/Storage/Recordings/CCTV" =
    { device = "/dev/sda";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=root" ];
    };

  fileSystems."/Storage/Snapshots" =
    { device = "/dev/sdb";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Snapshots" ];
    };

############
## SHARES ##
############
  services.nfs.server = {
    enable = true;
    exports = ''
      /Storage *(rw,anonuid=1000,anongid=100)
    '';
  };  
  
##########################
### VERSION AND REBOOT ###
##########################
  system = {
    stateVersion = "22.05";
    autoUpgrade.allowReboot = true;
  };
  
}
