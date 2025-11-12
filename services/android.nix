{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    androidStudioPackages.canary
  ];
}
