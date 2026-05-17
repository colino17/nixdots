{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    freecad
    orca-slicer
  ];
}
