{ config, pkgs, ... }:
{

  users.users.colin.extraGroups = [ "docker" ];

  networking.firewall.allowedTCPPorts = [ 2375 ]
  
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
    listenOptions = [ "/var/run/docker.sock" "0.0.0.0:2375" ];
  };
  
  virtualisation.oci-containers.backend = "docker";
  
  virtualisation.oci-containers.containers = {
    glances = {
      image = "nicolargo/glances:latest-alpine";
      autoStart = true;
      ports = [
        "61208:61208"
        "61209:61209"
      ];
      environment = {
        GLANCES_OPT = "-w";
      };
      extraOptions = [ "--pull=always" ];
    };
  };
  
}
