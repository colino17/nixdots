{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    yt-dlp
    ffmpeg
    gimp
    google-fonts
    jellyfin-media-player
  ];
}
