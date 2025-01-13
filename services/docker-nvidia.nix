{ config, pkgs, ... }:
{
  users.users.colin.extraGroups = [ "video" ];
  hardware.nvidia-container-toolkit.enable = true;
#  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_535;
}
