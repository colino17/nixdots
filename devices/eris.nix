{ config, pkgs, ... }:

{
  imports =
    [
      ../services/base.nix
      ../services/docker.nix
      ../services/docker-nvidia.nix
      ../services/nvidia.nix
      ../services/gnome.nix
      ../services/media.nix
      ../services/utilities.nix
      ../services/web.nix
      ../services/sound.nix
      ../services/uefi.nix
      ../services/mounts.nix
      ../users/colin.nix
      ../home.nix
      (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz}/nixos")
    ];
    
  networking = {
    hostName = "eris";
    interfaces.enp7s0.wakeOnLan.enable = true;
  };

################
## AUTO LOGIN ##
################
  services.xserver.displayManager = {
    autoLogin = {
      enable = true;
      user = "colin";
    };
    gdm.autoLogin.delay = 15;  
  };

##########################
### VERSION AND REBOOT ###
##########################
  system = {
    stateVersion = "23.05";
    autoUpgrade.allowReboot = false;
  };

}
