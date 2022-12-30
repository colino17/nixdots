{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    libimobiledevice
    ifuse
    shotwell
  ];
  
  service.usbmuxd.enable = true;
  
}
