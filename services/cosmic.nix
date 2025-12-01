{ config, pkgs, ... }:

{

## COSMIC DESKTOP ##
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  services.system76-scheduler.enable = true;

## EXCLUSIONS ##
  services.desktopManager.cosmic.showExcludedPkgsWarning = false;
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
    cosmic-player
    cosmic-files
  ];

## PACKAGES ##
  environment.systemPackages = with pkgs; [
    numix-icon-theme-circle
    clapper
    nautilus
  ];

## THEMING ##
  programs.firefox.preferences = {
    "widget.gtk.libadwaita-colors.enabled" = false;
  };

}
