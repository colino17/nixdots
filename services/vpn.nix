{ config, pkgs, ... }:
{
  services.tailscale.enable = true;
  environment.systemPackages = with pkgs; [
    gnomeExtensions.tailscale-status
  ];
}
