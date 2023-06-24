{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_hmversion; in

{
  imports =
    [
      ../services/adb.nix
      ../services/base.nix
      ../services/btrfs.nix
      ../services/flatpak.nix
      ../services/gnome.nix
      ../services/media.nix
      ../services/mounts.nix
      ../services/nvidia-mobile.nix
      ../services/sound.nix
      ../services/teamviewer.nix
      ../services/tlp.nix
      ../services/utilities.nix
      ../services/uefi.nix
      ../services/vpn.nix
      ../services/web.nix
      ../users/colin.nix
      ../home.nix
      (import "${builtins.fetchTarball var_hmversion}/nixos")
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
  system = {
    stateVersion = "22.11";
    autoUpgrade.allowReboot = false;
  };
  
}
