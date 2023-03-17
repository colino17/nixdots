{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
# Workstations
#      ./devices/dadmachine.nix
#      ./devices/loki.nix
#      ./devices/manticore.nix
#      ./devices/leviathan.nix
#      ./devices/maui.nix
# Servers
#      ./devices/osiris.nix
#      ./devices/anubis.nix
#      ./devices/isis.nix
    ];

################
### TIMEZONE ###
################
  time.timeZone = "Canada/Atlantic";

###################
### SSH SUPPORT ###
###################
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    ports = [ 1717 ];
  };

  services.fail2ban = {
    enable = true;
    maxretry = 5;
  };

###############
### ALIASES ###
###############
  environment.shellAliases = {
    rs = "sudo nixos-rebuild switch";
    rsu = "sudo nixos-rebuild switch --upgrade";
    garbage = "nix-collect-garbage -d";
    get = "cd /etc/nixos/ && sudo sh update.sh";
    la = "ls -a";
    c = "clear";
    reboot = "sudo reboot";
    poweroff = "sudo poweroff";
    shutdown = "sudo shutdown";
    mount = "sudo mount";
    upgrade = "upgrade() { sudo nix-channel --add https://nixos.org/channels/nixos-$1 nixos ;}; upgrade";
  };

##################################
### SYSTEM VERSION AND UPDATES ###
##################################
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };
  system = {
    autoUpgrade.enable = true;
    autoUpgrade.dates = "weekly";
    autoUpgrade.rebootWindow = {
      lower = "03:00";
      upper = "05:00";
    };
  };
}
