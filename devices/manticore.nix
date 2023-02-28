{ config, pkgs, ... }:

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
      (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz}/nixos")
    ];
    
  networking = {
    hostName = "manticore";
  };
  
##########################
### VERSION AND REBOOT ###
##########################
  system = {
    stateVersion = "22.11";
    autoUpgrade.allowReboot = false;
  };
  
}
