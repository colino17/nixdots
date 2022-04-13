{ config, pkgs, ... }:

#################
### TODO LIST ###
#################
# Remove unwanted gnome apps (ex: gnome-tour)
# Fix etcher/electron dependency issue
# Split Gnome config into separate file and/or add Sway config
# Investigate VFIO config
# Investigate Gnome Shell extensions (ex: POP tiling extension)
# Expand Home-Manager config
# Create Raspberry Pi config with full tailscale config
# Investigate variables
# Add GPRename
# Investigate garbage cleanup
# Create dev box build
# RDP stuff in gnome

################
### IMPORTS ###
################
{
  imports =
    [
      ./hardware-configuration.nix
      ./home.nix
      (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz}/nixos")
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
  environment.gnome.excludePackages = [ pkgs.gnome-tour ];
  services.dbus.packages = [ pkgs.dconf ];
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

################
### PRINTING ###
################  
  services.printing.enable = true;

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
  };

################
### PACKAGES ###
################
  nixpkgs.config.allowUnfree = true;
  documentation.nixos.enable = false;
  environment.systemPackages = with pkgs; [
    wget
    curl
    nfs-utils
    neofetch
    cmatrix
    youtube-dl
    ffmpeg
    discord
    gnome.gnome-system-monitor
    gnome-console
    gnome.eog
    gnome.gnome-tweaks
    gnome.dconf-editor
    gnome-text-editor
    gimp
    gnome.nautilus
    gnome.file-roller
    firefox-wayland
    home-manager
    numix-icon-theme-circle
    celluloid
    evince
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
  nix.autoOptimiseStore = true;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };
  system = {
    stateVersion = "21.11";
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
    autoUpgrade.dates = "daily";
  };
}
