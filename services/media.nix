{ config, pkgs, ... }:

{

# PACKAGES
  environment.systemPackages = with pkgs; [
    gimp
    inkscape
    google-fonts
    picard
  ];

}
