{ config, pkgs, ... }:

{
################
### PACKAGES ###
################
  environment.systemPackages = with pkgs; [
    btrfs-progs
    btrbk
  ];
  
  
  
  ### SNAPPER SERVICE??
  ### BTRBK SERVICE??
  
  
}
