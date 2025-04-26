{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_username; in

{
  imports =
    [
      ../services/base.nix
      ../services/cinnamon.nix
      ../services/sound.nix
      ../services/bios.nix
      ../services/printing.nix
      ../users/${var_username}.nix
    ];
    
  networking = {
    hostName = "karenmachine";
    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];
  };
  
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "karen";
 
  environment.systemPackages = with pkgs; [
    firefox
    gnome.aisleriot
    gnome.quadrapassel
    gnome.gnome-mahjongg
    gnome.gnome-mines
    gnome.gnome-nibbles
    gnome.gnome-sudoku
  ];

##########################
### VERSION AND REBOOT ###
##########################
system.autoUpgrade.allowReboot = false;
  
}
