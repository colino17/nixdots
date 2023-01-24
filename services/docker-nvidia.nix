{ config, pkgs, ... }:
{
  users.users.colin.extraGroups = [ "video" ];
  virtualisation.docker = {
    enableNvidia = true;
  };
}
