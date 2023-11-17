{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    x2goclient
  ];
}

