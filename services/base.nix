{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  documentation.nixos.enable = false;
  environment.systemPackages = with pkgs; [
    wget
    curl
    rsync
    unzip
    git
    nfs-utils
    usbutils
    pciutils
    lm_sensors
    yt-dlp
    ffmpeg
    cmatrix
    hollywood
    e2fsprogs
    iperf
    tmux
  ];
}
