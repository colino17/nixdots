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
    ];
    
  networking = {
    hostName = "dadmachine";
    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];
  };
  
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "dad";
 
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
