{ config, pkgs, ... }:

{
  imports =
    [
      ../services/base.nix
      ../services/cinnamon.nix
      ../services/vpn.nix
      ../services/sound.nix
      ../services/bios.nix
      ../services/printing.nix
      ../services/teamviewer.nix
      ../services/shotwell.nix
      ../users/dad.nix
      (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz}/nixos")
    ];
    
  networking = {
    hostName = "dadmachine";
  };
 
  environment.systemPackages = with pkgs; [
    firefox
    thunderbird
    clipgrab
    wpsoffice
  ];

##########################
### VERSION AND REBOOT ###
##########################
  system = {
    stateVersion = "22.11";
    autoUpgrade.allowReboot = false;
  };
  
}
