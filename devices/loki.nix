{ config, pkgs, ... }:

{
  imports =
    [
      ../services/base.nix
      ../services/easyeffects.nix
      ../services/gnome.nix
      ../services/media.nix
      ../services/utilities.nix
      ../services/web.nix
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

##########################
### VERSION AND REBOOT ###
##########################
  system = {
    stateVersion = "22.05";
    autoUpgrade.allowReboot = false;
  };

}
