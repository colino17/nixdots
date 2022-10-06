{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gimp
    google-fonts
    jellyfin-media-player
  ];
}
