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
  ];
}
