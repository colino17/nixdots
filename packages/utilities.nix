{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neofetch
    cmatrix
    appimage-run
    pciutils
  ];
}
