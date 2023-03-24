{ config, pkgs, ... }:

{
  imports =
    [
      ../services/amd.nix
      ../services/base.nix
      ../services/bios.nix
      ../services/bluetooth.nix
      ../services/btrfs.nix
      ../services/media.nix
      ../services/mounts.nix
      ../services/gnome.nix
      ../services/sound.nix
      ../services/steamos.nix
      ../services/web.nix
      ../users/colin.nix
    ];
    
##################
### NETWORKING ###
################## 
  networking = {
    hostName = "maui";
    interfaces.enp3s0 = {
      wakeOnLan.enable = true;
      ipv4.addresses = [ {
        address = "10.17.10.18";
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
    
  fileSystems."/Games" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Games" ];
    };

  fileSystems."/Backup/Files" =
    { device = "/dev/disk/by-label/backup";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Files" ];
    };

  fileSystems."/Backup/Media" =
    { device = "/dev/disk/by-label/backup";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=Media" ];
    };

################
## AUTO LOGIN ##
################
  services.xserver.displayManager = {
    autoLogin = {
      enable = true;
      user = "colin";
    };
    gdm.autoLogin.delay = 15;  
  };

##########################
### VERSION AND REBOOT ###
##########################
  system = {
    stateVersion = "22.11";
    autoUpgrade.allowReboot = false;
  };

}
