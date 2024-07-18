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
    internetarchive
    ffmpeg
    cmatrix
    e2fsprogs
    iperf
    tmux
  ];

## IPERF PORT ##
  networking.firewall.allowedTCPPorts = [ 5201 ];

}
