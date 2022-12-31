{ config, pkgs, ... }:
{
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.openFirewall = true;
  services.ipp-usb.enable = true;
}
