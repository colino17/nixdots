{ config, pkgs, ... }:

{
  imports =
    [
      ../services/adb.nix
      ../services/base.nix
      ../services/btrfs.nix
      ../services/games.nix
      ../services/gnome.nix
      ../services/media.nix
      ../services/mounts.nix
      ../services/nvidia.nix
      ../services/sound.nix
      ../services/teamviewer.nix
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
  
  environment.systemPackages = with pkgs; [
    asusctl
  ];
  
  services.asusd.enable = true;
  
##########################
### VERSION AND REBOOT ###
##########################
  system = {
    stateVersion = "22.11";
    autoUpgrade.allowReboot = false;
  };
  
}
