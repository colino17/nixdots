{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    gimp
    inkscape
    google-fonts
    jellyfin-media-player
    picard
  ];
  
}
