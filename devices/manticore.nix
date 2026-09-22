{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_username; in

{
  imports =
    [
      ../services/adb.nix
      ../services/asus.nix
      ../services/base.nix
      ../services/btrfs.nix
      ../services/cad.nix
      ../services/cosmic.nix
      ../services/desktop.nix
      ../services/flatpak.nix
      ../services/ide.nix
      ../services/media.nix
      ../services/mounts.nix
      ../services/rustdesk.nix
      ../services/sound.nix
      ../services/utilities.nix
      ../services/uefi.nix
      ../services/vpn.nix
      ../services/web.nix
      ../services/virt-viewer.nix
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
