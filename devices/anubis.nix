{ config, pkgs, ... }:

{
  imports =
    [
      ../services/base.nix
      ../services/btrfs.nix
      ../services/docker-agent.nix
      ../services/uefi.nix
      ../services/vpn.nix
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
      address = "10.17.10.16";
      prefixLength = 25;
    } ];
    defaultGateway = "10.17.10.1";
    nameservers = [
      "8.8.8.8"
      "8.8.1.1"
    ];
    hostName = "anubis";
  };
  
############
## MOUNTS ##
############
  fileSystems."/" =
    { fsType = "btrfs";
      options = [ "compress=zstd" "subvol=root" ];
    };
    
  fileSystems."/Storage/Configs" =
    { device = "/dev/disk/by-label/storage";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Configs" ];
    }; 

  fileSystems."/Storage/CCTV" =
    { device = "/dev/disk/by-label/storage";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=CCTV" ];
    };

############
## SHARES ##
############
  networking.firewall.allowedTCPPorts = [ 2049 ];
  services.nfs.server = {
    enable = true;
    createMountPoints = true;
    exports = ''
      /Storage *(ro,no_subtree_check,fsid=0)
      /Storage/Configs *(fsid=777,rw,sync,no_subtree_check)
      /Storage/CCTV *(fsid=888,rw,sync,no_subtree_check)
    '';
  };  
  
##########################
### VERSION AND REBOOT ###
##########################
  system = {
    stateVersion = "23.11";
    autoUpgrade.allowReboot = true;
  };
  
}
