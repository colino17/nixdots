{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_username; in

{
  imports =
    [
      ../services/base.nix
#      ../services/cad.nix
#      ../services/easyeffects.nix
#      ../services/flatpak.nix
#      ../services/gnome.nix
#      ../services/media.nix
      ../services/utilities.nix
      ../services/web.nix
#      ../services/vpn.nix
#      ../services/adb.nix
      ../services/sound.nix
#      ../services/uefi.nix
      ../services/bios.nix
#      ../services/printing.nix
#      ../services/mounts.nix
      ../services/virt-viewer.nix
#      ../services/x2go.nix
      ../users/${var_username}.nix
#      ../home.nix
    ];
    
  networking = {
    interfaces.eth0.wakeOnLan.enable = true;
    hostName = "cerberus";
  };

##########################
### VERSION AND REBOOT ###
##########################
system.autoUpgrade.allowReboot = false;

}
