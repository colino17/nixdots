{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    neofetch
    appimage-run
    geekbench
  ];
  
}
