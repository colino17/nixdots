{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    librewolf-wayland
  ];
}
