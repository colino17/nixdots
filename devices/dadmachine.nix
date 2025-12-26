{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_username; in

{
  imports =
    [
      ../services/base.nix
      ../services/cinnamon.nix
      ../services/vpn.nix
      ../services/sound.nix
      ../services/bios.nix
      ../services/printing.nix
      ../services/rustdesk.nix
      ../services/scanning.nix
      ../services/shotwell.nix
      ../users/${var_username}.nix
    ];
    
  networking = {
    hostName = "dadmachine";
    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];
  };
  
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "${var_username}";
 
  environment.systemPackages = with pkgs; [
    firefox
    thunderbird
    video-downloader
    wpsoffice
  ];

##########################
### VERSION AND REBOOT ###
##########################
system.autoUpgrade.allowReboot = false;
  
}
