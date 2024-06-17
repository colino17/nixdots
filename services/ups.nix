{ config, pkgs, ... }:
{
  power.ups = { 
    enable = true;
    mode = "netserver";
    openFirewall = true;
    ups = {
      port = "auto";
      driver = "usbhid-ups";
      pollinterval = "15";
      maxretry = "5";
    };
    upsd = {
      enable = true;
      listen = [ {
        address = "0.0.0.0";
      } ];
      extraConfig = "MAXAGE 25";
    };
  };
