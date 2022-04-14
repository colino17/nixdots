{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./packages/base.nix
      ./packages/gnome.nix
      ./packages/media.nix
      ./packages/utilities.nix
      ./packages/web.nix
      ./services/vpn.nix
      ./services/games.nix
      ./services/base.nix
      ./services/uefi.nix
      ./home.nix
      (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz}/nixos")
    ];
}
