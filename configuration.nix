{ config, pkgs, ... }:

################
### IMPORTS ###
################
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

#########################
### BOOTLOADER - BIOS ###
#########################
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

################
### TIMEZONE ###
################
  time.timeZone = "Canada/Atlantic";

##################
### NETWORKING ###
##################
  networking.useDHCP = false;
  networking.interfaces.enp12s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.hostName = "nixos";
  services.tailscale = { enable = true; };

#####################
### GNOME DESKTOP ###
#####################
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.core-utilities.enable = false;

######################
### GNOME SETTINGS ###
######################
  services.xserver.desktopManager.gnome = {
    extraGSettingsOverrides = ''
      # Change default background
      [org.gnome.desktop.background]
      picture-uri='file://${pkgs.nixos-artwork.wallpapers.mosaic-blue.gnomeFilePath}'

      # Favorite apps in gnome-shell
      [org.gnome.shell]
      favorite-apps=['org.gnome.Photos.desktop', 'org.gnome.Nautilus.desktop']
    '';

    extraGSettingsOverridePackages = [
      pkgs.gsettings-desktop-schemas # for org.gnome.desktop
      pkgs.gnome.gnome-shell # for org.gnome.shell
      ];
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
  
#############
### USERS ###
#############
  users.users.colin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

################
### PACKAGES ###
################
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
    google-chrome
    discord
    baobab
    gnome.gnome-system-monitor
    gnome.gnome-terminal
    gnome.eog
    gnome.gnome-tweaks
    gnome.dconf-editor
    lighttable
    gnome.gedit
    lite
    lite-xl
    vscode
    gimp
    gnome.nautilus
    gnome.file-roller
    szyszka
  ];

#####################
### STEAM SUPPORT ###
#####################  
  programs.steam.enable = true;

###################
### SSH SUPPORT ###
###################
  services.openssh.enable = true;
  
###################
### NFS SUPPORT ###
###################
  
{
  fileSystems."/mnt/Storage" = {
    device = "server:/Storage";
    fsType = "nfs";
  };
  fileSystems."/mnt/Backup" = {
    device = "server:/Backup";
    fsType = "nfs";
  };
}

##################################
### SYSTEM VERSION AND UPDATES ###
##################################
  system.stateVersion = "21.11";
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  nixpkgs.config.allowUnfree = true;
}
