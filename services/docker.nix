{ config, pkgs, ... }:
{

  users.users.colin.extraGroups = [ "docker" ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    enableNvidia = true;
    autoPrune.enable = true;
  };
  
}
