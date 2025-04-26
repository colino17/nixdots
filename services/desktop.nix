{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_username; in

{

  home-manager.users.${var_username} = { config, ... }: {
#######################
### DESKTOP ENTRIES ###
#######################
    xdg.desktopEntries.renamer = {
          name = "Renamer";
          genericName = "Renamer";
          exec = "appimage-run /Storage/Files/Packages/APPS/renamer.AppImage";
          terminal = false;
          icon = "gprename";
    };
    
########################
### WALLPAPER FOLDER ###
########################
    home.file."Pictures/Wallpapers" = {
      source = /etc/nixos/wallpapers;
      recursive = true;
    };

}
