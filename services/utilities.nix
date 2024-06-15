{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    fastfetch
    appimage-run
  ];
  
}
