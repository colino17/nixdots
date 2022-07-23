{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  documentation.nixos.enable = false;
  environment.systemPackages = with pkgs; [
    wget
    curl
    rsync
    nfs-utils
    unzip
    git
    lm_sensors
    usbutils
  ];
}
