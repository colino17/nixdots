{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_username; in

{
  imports =
    [
      ../services/adb.nix
      ../services/base.nix
      ../services/btrfs.nix
      ../services/cad.nix
      ../services/flatpak.nix
      ../services/gnome.nix
      ../services/media.nix
      ../services/mounts.nix
      ../services/nvidia-mobile.nix
      ../services/sound.nix
      ../services/tlp.nix
      ../services/utilities.nix
      ../services/uefi.nix
      ../services/vpn.nix
      ../services/web.nix
      ../services/virt-viewer.nix
      ../services/x2go.nix
      ../users/${var_username}.nix
    ];
    
  networking = {
    hostName = "manticore";
  };

  environment.systemPackages = with pkgs; [
    cabextract
  ];
  
##########################
### VERSION AND REBOOT ###
##########################
system.autoUpgrade.allowReboot = false;
  
}
