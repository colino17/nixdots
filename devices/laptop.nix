{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./packages/base.nix
      ./packages/desktop.nix
      ./packages/desktops/gnome.nix
      ./services/vpn.nix
      ./services/games.nix
      ./services/base.nix
#      ./services/bootloader/uefi.nix
      ./services/bootloader/bios.nix
      ./home.nix
      (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz}/nixos")
    ];
}
