{ config, pkgs, ... }:

{
################
### PACKAGES ###
################
  environment.systemPackages = with pkgs; [
    btrfs-progs
    btrbk
  ];
  
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };
  
}
