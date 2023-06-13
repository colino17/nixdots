{ config, pkgs, ... }:

let gasket = config.boot.kernelPackages.callPackage /etc/nixos/packages/coral.nix {}; in
{
  boot.extraModulePackages = [ gasket ];
}
