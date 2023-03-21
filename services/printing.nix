{ config, pkgs, ... }:
{
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    openFirewall = true;
    nssmdns = true;
  };

  services.ipp-usb.enable=true;
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
  };
  environment.systemPackages = with pkgs; [
    gnome.simple-scan
  ];
  
}
