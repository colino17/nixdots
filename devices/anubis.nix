{ config, pkgs, ... }:

{
  imports =
    [
      ../packages/base.nix
      ../services/uefi.nix
      ../services/vpn.nix
      ../services/docker.nix
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
      address = "10.17.80.33";
      prefixLength = 24;
    } ];
    defaultGateway = "10.17.80.1";
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
    { device = "/dev/sda";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=root" ];
    };

  fileSystems."/Recordings/CCTV" =
    { device = "/dev/sda";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Recordings" ];
    };

############
## SHARES ##
############
  services.nfs.server = {
    enable = true;
    exports = ''
      /Recordings/CCTV *(rw,anonuid=1000,anongid=100)
    '';
  };  
  
##########################
### VERSION AND REBOOT ###
##########################
  system = {
    stateVersion = "22.11";
    autoUpgrade.allowReboot = true;
  };
  
}
