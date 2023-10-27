{ config, pkgs, ... }:

{
  imports =
    [
      ../services/base.nix
      ../services/btrfs.nix
      ../services/uefi.nix
      ../services/vpn.nix
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

############
## SHARES ##
############
  services.nfs.server = {
    enable = true;
    createMountPoints = true;
    exports = ''
      /Backup *(ro,no_subtree_check,fsid=0)
      /Backup/Configs *(fsid=1111,ro,sync,no_subtree_check)
      /Backup/Files *(fsid=2222,ro,sync,no_subtree_check)
      /Backup/Media *(fsid=3333,ro,sync,no_subtree_check)
    '';
  };  

##########################
### VERSION AND REBOOT ###
##########################
  system = {
    stateVersion = "23.05";
    autoUpgrade.allowReboot = false;
  };
  
}
