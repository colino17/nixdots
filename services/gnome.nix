{ config, pkgs, ... }:

{

## GNOME DESKTOP ##
  services.gnome.core-utilities.enable = false;
  services.dbus.packages = [ pkgs.dconf ];
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

## PACKAGES ##
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
    gnomeExtensions.forge
    gnomeExtensions.tailscale-status
    virt-viewer
  ];

## EXCLUSIONS ##
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
  ];

## SETUP USB REDIRECTION FOR REMOTE-VIEWER ##
  virtualisation.spiceUSBRedirection.enable = true;

}
