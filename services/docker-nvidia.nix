{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_username; in

{
  users.users.${var_username}.extraGroups = [ "video" ];
  hardware.nvidia-container-toolkit.enable = true;
#  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_535;
}
