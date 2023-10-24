{ config, pkgs, ... }:

let libedgetpu = config.boot.kernelPackages.callPackage /etc/nixos/packages/coral.nix {}; in
{
  services.udev.packages = [ libedgetpu ];                                                                                                                                                                                              
  users.groups.plugdev = {};  
}
