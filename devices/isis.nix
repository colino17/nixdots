{ config, pkgs, ... }:

{
  imports =
    [
      ../packages/base.nix
      ../services/uefi.nix
      ../services/mounts.nix
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
      address = "10.17.10.18";
      prefixLength = 24;
    } ];
    defaultGateway = {
      address = "10.17.10.1";
      interface = "eth0";
    };
    nameservers = [
      "8.8.8.8"
      "8.8.1.1"
    ];
    hostName = "isis";
  };

################
## AUTO LOGIN ##
################
  services.getty.autologinUser = "colin";
  
############
## BACKUP ##
############
  programs.bash.loginShellInit = "sh /etc/nixos/scripts/backup.sh";
  
############
## MOUNTS ##
############
  fileSystems."/Backup" = {
    device = "/dev/vg_backup/lv_backup";
    fsType = "ext4";
  };

##########################
### VERSION AND REBOOT ###
##########################
  system = {
    stateVersion = "22.11";
    autoUpgrade.allowReboot = false;
  };

}
