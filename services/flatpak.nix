{ config, pkgs, ... }:
{
  services.flatpak.enable = true;
  hardware.steam-hardware.enable = true;
}
