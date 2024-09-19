{ config, pkgs, ... }:
{
  users.users.colin.extraGroups = [ "video" ];
  hardware.nvidia-container-toolkit.enable = true;
}
