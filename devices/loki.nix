{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_hmversion; in

{
  imports =
    [
      ../services/base.nix
      ../services/cad.nix
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
      ../services/x2go.nix
      ../users/colin.nix
      ../home.nix
      (import "${builtins.fetchTarball var_hmversion}/nixos")
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
  };

  # Workaround for Current Gnome Bug
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

##########################
### VERSION AND REBOOT ###
##########################
  system = {
    stateVersion = "22.05";
    autoUpgrade.allowReboot = false;
  };

}
