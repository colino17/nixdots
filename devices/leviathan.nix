{ config, pkgs, ... }:

{
  imports =
    [
      ../services/base.nix
      ../services/gnome.nix
      ../services/media.nix
      ../services/utilities.nix
      ../services/web.nix
      ../services/vpn.nix
      ../services/adb.nix
      ../services/sound.nix
      ../services/games.nix
      ../services/bios.nix
      ../services/printing.nix
      ../services/mounts.nix
      ../users/colin.nix
      ../home.nix
      (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz}/nixos")
    ];
    
  networking = {
    useDHCP = false;
    interfaces.enp12s0.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
    hostName = "leviathan";
  };
  
##########################
### VERSION AND REBOOT ###
##########################
  system = {
    stateVersion = "22.11";
    autoUpgrade.allowReboot = false;
  };

}
