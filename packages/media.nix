{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    youtube-dl
    ffmpeg
    gimp
    celluloid
    google-fonts
  ];
}
