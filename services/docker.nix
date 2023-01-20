{ config, pkgs, ... }:
{

  users.users.colin.extraGroups = [ "docker" ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };
  
  virtualisation.oci-containers.backend = "docker";
  
  virtualisation.oci-containers.containers = {
    portainer = {
      image = "portainer/portainer-ce:latest";
      autoStart = true;
      ports = [
        "8000:8000"
        "9443:9443"
      ];
      volumes = [
        "/Storage/Configs/portainer:/data"
        "/var/run/docker.sock:/var/run/docker.sock"
      ];
    };
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
    };
    autoheal = {
      image = "willfarrell/autoheal@sha256:d5a004f6ab41371b3562339d0ca4c03765082fc744a28e4049dd42ac418d60c5";
      autoStart = true;
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
      ];
      environment = {
        AUTOHEAL_CONTAINER_LABEL = "all";
      };
    };
  };
  
}
