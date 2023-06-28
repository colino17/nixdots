{ config, pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [
    makemkv
  ];

}
