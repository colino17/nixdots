{ config, pkgs, ... }:

{
  power.ups = { 
    enable = true;
    mode = "netserver";
    openFirewall = true;
    ups.${config.networking.hostName} = {
      port = "auto";
      driver = "usbhid-ups";
      summary = ''
        pollinterval = 15
      '';
    };
    upsd = {
      enable = true;
      listen = [ {
        address = "0.0.0.0";
      } ];
      extraConfig = "MAXAGE 25";
    };
    upsmon = {
      settings = {
        MINSUPPLIES = 0;
      };
    };
  };
}
