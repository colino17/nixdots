{ config, pkgs, ... }:
{

  services.caddy = {
    enable = true;
    virtualHosts."dockge.local".extraConfig = ''
      reverse_proxy 10.17.10.17:5001
    '';
    virtualHosts."nvr.local".extraConfig = ''
      reverse_proxy 10.17.10.16:5000
    '';
    virtualHosts."hdd.local".extraConfig = ''
      reverse_proxy 10.17.10.17:8077
    '';
    virtualHosts."esp.local".extraConfig = ''
      reverse_proxy 10.17.10.16:6052
    '';
    virtualHosts."threadfin.local".extraConfig = ''
      reverse_proxy /web 10.17.10.16:34400
    '';
    virtualHosts."logs.local".extraConfig = ''
      reverse_proxy 10.17.10.17:7373
    '';
    virtualHosts."zwave.local".extraConfig = ''
      reverse_proxy 10.17.10.17:8091
    '';
    virtualHosts."llm.local".extraConfig = ''
      reverse_proxy 10.17.10.17:4242
    '';
    virtualHosts."notes.local".extraConfig = ''
      reverse_proxy 10.17.10.17:9292
    '';
    virtualHosts."wiki.local".extraConfig = ''
      reverse_proxy 10.17.10.17:9393
    '';
    virtualHosts."search.local".extraConfig = ''
      reverse_proxy 10.17.10.17:2727
    '';
    virtualHosts."dl.local".extraConfig = ''
      reverse_proxy 10.17.10.17:9099
    '';
  };



  
}
