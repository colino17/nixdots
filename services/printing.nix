{ config, pkgs, ... }:
{

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    openFirewall = true;
    nssmdns = true;
  };
  
}
