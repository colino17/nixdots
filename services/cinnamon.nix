{ config, pkgs, ... }:

{

  services.cinnamon.apps.enable = false;
  services.dbus.packages = [ pkgs.dconf ];
  
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.cinnamon.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome-console
    blueberry
    gnome.file-roller
    gnome.gnome-disk-utility
    xed-editor
    celluloid
  ];
   
}
