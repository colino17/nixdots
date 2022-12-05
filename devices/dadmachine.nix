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

##########################
### VERSION AND REBOOT ###
##########################
  system = {
    stateVersion = "22.11";
    autoUpgrade.allowReboot = false;
  };
  
}
