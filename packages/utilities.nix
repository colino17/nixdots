{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neofetch
    cmatrix
    appimage-run
    (callPackage ../custom/gprename/gprename.nix {})
  ];
}
