{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neofetch
    cmatrix
    appimage-run
    (callPackage ../packages/custom/gprename/gprename.nix {})
  ];
}
