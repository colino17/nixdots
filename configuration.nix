{ config, pkgs, ... }:

################
### IMPORTS ###
################
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports =
    [
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
      ./home.nix
    ];

#########################
### BOOTLOADER - BIOS ###
#########################
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

#########################
### BOOTLOADER - UEFI ###
#########################
#  boot.loader.systemd-boot = {
#    enable = true;
#    configurationLimit = 3;
#    editor = false;
#  };

#############
### USERS ###
#############
  users.users.colin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  
################
### TIMEZONE ###
################
  time.timeZone = "Canada/Atlantic";

##################
### NETWORKING ###
##################
  networking = {
    useDHCP = false;
    interfaces.enp12s0.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
    hostName = "nixos";
  };
  
###########
### VPN ###
###########
  services.tailscale = { enable = true; };

#####################
### GNOME DESKTOP ###
#####################
  services.gnome.core-utilities.enable = false;
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

################
### PRINTING ###
################  
  services.printing.enable = false;

#############
### SOUND ###
#############
  hardware.pulseaudio.enable = false;
  sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    media-session.enable = true;
  };

################
### PACKAGES ###
################
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    wget
    curl
    htop
    etcher
    nfs-utils
    neofetch
    cmatrix
    tailscale
    youtube-dl
    mpv-unwrapped
    ffmpeg
    discord
    baobab
    gnome.gnome-system-monitor
    gnome.gnome-terminal
    gnome.eog
    gnome.gnome-tweaks
    gnome.dconf-editor
    gnome.gedit
    gimp
    gnome.nautilus
    gnome.file-roller
    szyszka
    epiphany
  ];

#####################
### STEAM SUPPORT ###
#####################  
  programs.steam.enable = true;

###################
### SSH SUPPORT ###
###################
  services.openssh.enable = true;

##################################
### SYSTEM VERSION AND UPDATES ###
##################################
  system = {
    stateVersion = "21.11";
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
  };
}
