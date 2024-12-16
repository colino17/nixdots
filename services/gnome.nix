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
    gnome-system-monitor
    gnome-console
    eog
    gnome-tweaks
    dconf-editor
    gnome-text-editor
    nautilus
    file-roller
    numix-icon-theme-circle
    celluloid
    evince
    gnomeExtensions.vitals
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.forge
    gnomeExtensions.tailscale-qs
    virt-viewer
  ];

## EXCLUSIONS ##
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
  ];

## SETUP USB REDIRECTION FOR REMOTE-VIEWER ##
  virtualisation.spiceUSBRedirection.enable = true;

}
