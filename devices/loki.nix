{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_username; in

{
  imports =
    [
      ../services/base.nix
      ../services/cad.nix
      ../services/desktop.nix
      ../services/easyeffects.nix
      ../services/flatpak.nix
      ../services/gnome.nix
      ../services/media.nix
      ../services/utilities.nix
      ../services/web.nix
      ../services/vpn.nix
      ../services/adb.nix
      ../services/sound.nix
      ../services/uefi.nix
      ../services/printing.nix
      ../services/mounts.nix
      ../services/virt-viewer.nix
      ../services/x2go.nix
      ../users/${var_username}.nix
    ];
    
  networking = {
    interfaces.eth0.wakeOnLan.enable = true;
    hostName = "loki";
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
