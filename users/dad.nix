{ config, pkgs, ... }:

{

  users.users.dad = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  
)
