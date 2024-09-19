{ config, pkgs, ... }:
{

  networking.firewall.allowedTCPPorts = [ 2375 ];
  
  virtualisation.docker = {
    listenOptions = [ "/var/run/docker.sock" "0.0.0.0:2375" ];
  };

}
