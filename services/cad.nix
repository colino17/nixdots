{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    freecad
    bambu-studio
  ];
}
