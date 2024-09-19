{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_hostname; in

{

  users.users.colin.extraGroups = [ "docker" ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };
  
  virtualisation.oci-containers.backend = "docker";
  
  virtualisation.oci-containers.containers = {
    dockge = {
      image = "louislam/dockge:latest";
      autoStart = true;
      ports = [
        "5001:5001"
      ];
      volumes = [
        "/Storage/Configs/compose/${var_hostname}:/opt/stacks"
        "/Storage/Configs/dockge:/app/data"
        "/var/run/docker.sock:/var/run/docker.sock"
      ];
      extraOptions = [ "--pull=always" ];
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
      extraOptions = [ "--pull=always" ];
    };
  };
  
}
