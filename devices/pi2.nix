{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./packages/base.nix
      ./packages/dev.nix
      ./packages/pi.nix
      ./services/vpn.nix
      ./services/base.nix
    ];
}
