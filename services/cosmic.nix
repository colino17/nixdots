{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_username; in

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
    pcmanfm
  ];

## THEMING ##
  home-manager.users.${var_username} = { config, ... }: {
    gtk = {
      enable = true;
      theme = {
y        package = pkgs.tokyonight-gtk-theme;
      };
      iconTheme = {
        name = "Tela-circle-dark";
        package = pkgs.tela-circle-icon-theme;
      };
    };
  };

}
