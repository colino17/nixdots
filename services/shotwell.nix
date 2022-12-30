{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    libimobiledevice
    ifuse
    shotwell
  ];
  
  services.usbmuxd.enable = true;
  
}
