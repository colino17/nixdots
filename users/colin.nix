{ config, pkgs, ... }:

{

  users.users.colin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  
}
