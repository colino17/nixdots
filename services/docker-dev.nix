{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_username; in

{

  users.users.${var_username}.extraGroups = [ "docker" ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
    storageDriver = "overlay2";
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
        "/home/${var_username}/.compose/dockge/stacks:/opt/stacks"
        "/home/${var_username}/.compose/dockge/data:/app/data"
        "/var/run/docker.sock:/var/run/docker.sock"
      ];
      extraOptions = [ "--pull=always" ];
    };
  };
  
}
