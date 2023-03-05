{ config, pkgs, ... }:

{

  services.gnome.core-utilities.enable = false;
  services.dbus.packages = [ pkgs.dconf ];
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome.gnome-system-monitor
    gnome-console
    gnome.eog
    gnome.gnome-tweaks
    gnome.dconf-editor
    gnome-text-editor
    gnome.nautilus
    gnome.file-roller
    numix-icon-theme-circle
    celluloid
    evince
    gnomeExtensions.vitals
    gnomeExtensions.tray-icons-reloaded
  ];
  
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
  ];
  
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = 
    ''
      [org.gnome.nautilus.list-view]
      default-visible-columns="['name', 'size', 'detailed_type', 'date_modified_with_time']"
    ''

  
 
  
  
}
