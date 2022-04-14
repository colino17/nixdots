{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    firefox-wayland
  ];
}
