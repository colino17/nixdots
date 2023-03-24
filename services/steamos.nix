{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in 

{

## STEAM INSTALL ##
  hardware.steam-hardware.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  
 ## PACKAGES ##
  environment.systemPackages = with pkgs; [
    gamescope
    mangohud
    pcsx2
    dolphin-emu
    unstable.xemu
    snes9x-gtk
  ];

## GAMESCOPE SESSION ##
  services.xserver.displayManager = {
    session = [
      {
        manage = "desktop";
        name = "Gamescope";
        start = "gamescope -e -f -h 1080 -H 1080 -r 60 -- steam --gamepadui --steamos";
      }
    ];
    defaultSession = "Gamescope";
  };

}
