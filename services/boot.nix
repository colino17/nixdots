{ config, pkgs, ... }:

{
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 3;
    editor = false;
  };
  
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };
}
