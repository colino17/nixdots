{ config, pkgs, ... }:

{
  imports =
    [
      ../packages/base.nix
      ../packages/gnome.nix
      ../packages/media.nix
      ../packages/utilities.nix
      ../packages/web.nix
      ../services/vpn.nix
      ../services/adb.nix
      ../services/sound.nix
      ../services/vfio.nix
      ../services/printing.nix
      ../services/mounts.nix
      ../home.nix
      (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz}/nixos")
    ];
    
  networking = {
    hostName = "loki";
  };

  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "colin";
  };


}
