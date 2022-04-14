{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    youtube-dl
    ffmpeg
    gimp
    google-fonts
  ];
}
