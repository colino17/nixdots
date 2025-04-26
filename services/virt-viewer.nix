{ config, pkgs, ... }:

{
  virtualisation.spiceUSBRedirection.enable = true;
  environment.systemPackages = with pkgs; [
    virt-viewer
  ];
}
