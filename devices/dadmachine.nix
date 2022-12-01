{ config, pkgs, ... }:

{
  imports =
    [
      ../packages/base.nix
      ../packages/cinnamon.nix
      ../packages/web.nix
      ../services/vpn.nix
      ../services/sound.nix
      ../services/uefi.nix
      ../services/printing.nix
      ../services/mounts.nix
      ../users/dad.nix
      ../home.nix
      (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz}/nixos")
    ];
    
  networking = {
    hostName = "dadmachine";
  };
 
  environment.systemPackages = with pkgs; [
    google-chrome
    thunderbird
    clipgrab
    wpsoffice
  ];

  services.teamviewer.enable = true;

##############
### REBOOT ###
##############
  system.autoUpgrade.allowReboot = false;
  
}
