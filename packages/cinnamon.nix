{ config, pkgs, ... }:

{
  services.gnome.core-utilities.enable = false;
  services.dbus.packages = [ pkgs.dconf ];
  
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.cinnamon.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome.dconf-editor
  ];
  
  environment.cinnamon.excludePackages = with pkgs; [
    cinnamon.warpinator
    cinnamon.pix
    hexchat
  ];
  
}
