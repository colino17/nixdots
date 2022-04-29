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
      ../services/sound.nix
      ../services/games.nix
      ../services/bios.nix
      ../services/printing.nix
      ../home.nix
      (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz}/nixos")
    ];
    
  networking = {
    useDHCP = false;
    interfaces.enp12s0.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
    hostName = "leviathan";
  };
}
