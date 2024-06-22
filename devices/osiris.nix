{ config, pkgs, ... }:

{
  imports =
    [
      ../services/base.nix
      ../services/btrfs.nix
      ../services/docker.nix
      ../services/docker-nvidia.nix
      ../services/nvidia.nix
      ../services/realesrgan.nix
      ../services/uefi.nix
      ../services/ups.nix
      ../services/vpn.nix
      ../users/colin.nix
    ];

##################
### NETWORKING ###
##################
  networking = {
    firewall.allowedTCPPorts = [ 2049 1883 8123 8096 11434 49152 ];
    interfaces.enp4s0.wakeOnLan.enable = true;
    useDHCP = false;
    interfaces.enp4s0.ipv4.addresses = [ {
      address = "10.17.10.17";
      prefixLength = 25;
    } ];
    defaultGateway = "10.17.10.1";
    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];
    hostName = "osiris";
  };

############
## MOUNTS ##
############
  fileSystems."/" =
    { fsType = "btrfs";
      options = [ "compress=zstd" "subvol=root" ];
    };
    
  fileSystems."/Storage/Configs" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Configs" ];
    };

  fileSystems."/Storage/Files" =
    { device = "/dev/disk/by-label/storage";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Files" ];
    };

  fileSystems."/Storage/Media" =
    { device = "/dev/disk/by-label/storage";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Media" ];
    };

  fileSystems."/Storage/Recordings" =
    { device = "/dev/disk/by-label/recordings";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Recordings" ];
    };

  fileSystems."/Storage/Snapshots" =
    { device = "/dev/disk/by-label/storage";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Snapshots" ];
    };

############
## SHARES ##
############
  services.nfs.server = {
    enable = true;
    createMountPoints = true;
    exports = ''
      /Storage *(ro,no_subtree_check,fsid=0)
      /Storage/Configs *(fsid=111,rw,sync,no_subtree_check)
      /Storage/Files *(fsid=222,rw,sync,no_subtree_check)
      /Storage/Media *(fsid=333,rw,sync,no_subtree_check)
      /Storage/Recordings *(fsid=444,rw,sync,no_subtree_check)
      /Storage/Snapshots *(fsid=555,rw,sync,no_subtree_check)
    '';
  };  
  
#############
## BACKUPS ##
#############
  services.btrbk.instances = {
    local = {
      onCalendar = "daily";
      settings = {
        snapshot_dir = "/Storage/Snapshots";
        snapshot_preserve_min = "2d";
        snapshot_create = "always";
        snapshot_preserve = "3d 2w 2m";
        subvolume."/Storage/Files" = { };
        subvolume."/Storage/Media" = { };
      };
    };
    config = {
      onCalendar = "daily";
      settings.volume = {
        "/" = {
          snapshot_dir = "/.snapshots";
          subvolume."/Storage/Configs" = {
            snapshot_preserve_min = "2d";
            snapshot_create = "always";
            snapshot_preserve = "3d 2w 2m";
          };
          target = "/Storage/Snapshots";        
        };
      };
    };
  };
  
##########################
### VERSION AND REBOOT ###
##########################
  system = {
    stateVersion = "22.11";
    autoUpgrade.allowReboot = true;
  };
  
}
