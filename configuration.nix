{ config, pkgs, ... }:

let inherit (import ./variables.nix) var_hostname; in

{
  imports =
    [
      ./hardware-configuration.nix
      ./devices/${var_hostname}.nix
    ];

############
### BOOT ###
############
  boot.loader.timeout = 30;

################
### TIMEZONE ###
################
  time.timeZone = "Canada/Atlantic";

###################
### SSH SUPPORT ###
###################
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
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
    rb = "sudo nixos-rebuild boot";
    garbage = "nix-collect-garbage -d";
    repair = "sudo nix-store --verify --repair --check-contents";
    get = "cd /etc/nixos/ && sudo sh update.sh";
    la = "ls -a";
    c = "clear";
    reboot = "sudo reboot";
    poweroff = "sudo poweroff";
    shutdown = "sudo shutdown";
    mount = "sudo mount";
    usage = "sudo btrfs filesystem usage";
    upgrade = "upgrade() { sudo nix-channel --add https://nixos.org/channels/nixos-$1 nixos ;}; upgrade";
    channel = "sudo nix-channel --list | cut -d'-' -f2";
    vm = "quickemu --display spice --viewer none --access remote --vm";
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
