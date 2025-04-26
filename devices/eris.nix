{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_username; in

{
  imports =
    [
      ../services/base.nix
      ../services/cad.nix
      ../services/desktop.nix
      ../services/realesrgan.nix
      ../services/nvidia.nix
      ../services/makemkv.nix
      ../services/gnome.nix
      ../services/media.nix
      ../services/utilities.nix
      ../services/web.nix
      ../services/sound.nix
      ../services/boot.nix
      ../services/mounts.nix
      ../users/${var_username}.nix
      ../home.nix
    ];
    
  networking = {
    hostName = "eris";
    interfaces.enp6s0.wakeOnLan.enable = true;
  };

################
## AUTO LOGIN ##
################
  services.xserver.displayManager = {
    autoLogin = {
      enable = true;
      user = "${var_username}";
    }; 
  };

  # Workaround for Current Gnome Bug
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

##########################
### VERSION AND REBOOT ###
##########################
system.autoUpgrade.allowReboot = false;

}
