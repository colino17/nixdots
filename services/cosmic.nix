{ config, pkgs, ... }:

{

## COSMIC DESKTOP ##
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

## EXCLUSIONS ##
  services.desktopManager.cosmic.showExcludedPkgsWarning = false;
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
    cosmic-player
  ];

## PACKAGES ##
  environment.systemPackages = with pkgs; [
    numix-icon-theme-circle
    clapper
  ];

}
