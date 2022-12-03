{ config, pkgs, ... }:

{
  imports =
    [
      ../packages/base.nix
      ../packages/gnome.nix
      ../packages/media.nix
      ../packages/utilities.nix
      ../packages/web.nix
      ../services/vpn.nix
      ../services/adb.nix
      ../services/sound.nix
      ../services/vfio.nix
      ../services/printing.nix
      ../services/mounts.nix
      ../services/teamviewer.nix
      ../users/colin.nix
      ../home.nix
      (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz}/nixos")
    ];
    
  networking = {
    hostName = "loki";
    interfaces.enp7s0.wakeOnLan.enable = true;
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

##############
### REBOOT ###
##############
  system.autoUpgrade.allowReboot = false;

}
