{ config, pkgs, ... }:

{
  imports =
    [
      ../packages/base.nix
      ../services/uefi.nix
      ../services/mounts.nix
    ];

##################
### NETWORKING ###
##################
  networking = {
    useDHCP = false;
    usePredictableInterfaceNames = false;
    interfaces.eth0.ipv4.addresses = [ {
      address = "192.168.0.18";
      prefixLength = 24;
    } ];
    defaultGateway = "192.168.0.1";
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
  programs.bash.loginShellInit = "sh /etc/nixos/scripts/backup.sh"
  
############
## MOUNTS ##
############
  fileSystems."/Backup" = {
    device = "/dev/vg_backup/lv_backup";
    fsType = "ext4";
  };

}
