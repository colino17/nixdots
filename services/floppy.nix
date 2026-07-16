{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    ufiformat
  ];

  boot.kernelModules = [ "sg" ];
  
}
