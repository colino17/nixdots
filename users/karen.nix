{ config, pkgs, ... }:

{

  users.users.karen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "scanner" "lp"  ];
  };
  
}
