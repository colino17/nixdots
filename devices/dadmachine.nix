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
      ../services/teamviewer.nix
      ../users/dad.nix
      (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz}/nixos")
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

##############
### REBOOT ###
##############
  system.autoUpgrade.allowReboot = false;
  
}
