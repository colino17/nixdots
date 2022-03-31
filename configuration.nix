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
      [org.gnome.desktop.background]
      picture-uri='file://${pkgs.nixos-artwork.wallpapers.mosaic-blue.gnomeFilePath}'
     
      [org.gnome.settings-daemon.plugins.media-keys]
      custom-keybindings=['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/' '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/' '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/' '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/' '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/' '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/']

      [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0]
      binding='<Super>t'
      command='gnome-terminal'
      name='open-terminal' 
      
      [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom1]
      binding='<Super>e'
      command='nautilus'
      name='open-files'
      
      [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom2]
      binding='<Super>w'
      command='epiphany'
      name='open-web'
      
      [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom3]
      binding='<Super>d'
      command='discord'
      name='open-discord'
      
      [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom4]
      binding='<Super>g'
      command='gimp'
      name='open-gimp'
      
      [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom5]
      binding='<Super>m'
      command='gnome-terminal --maximize -- bash -c cmatrix -bas'
      name='enter-matrix'
      
      [org.gnome.shell]
      favorite-apps=['org.gnome.Epiphany.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'gimp.desktop', 'discord.desktop', 'steam.desktop']
    '';

    extraGSettingsOverridePackages = [
      pkgs.gsettings-desktop-schemas
      pkgs.gnome.gnome-shell
      pkgs.gnome.gnome-settings-daemon
      ];
    };

services.xserver.desktopManager.gnome3 = {
    extraGSettingsOverridePackages = with pkgs; [ gnome3.gnome-settings-daemon ];
    extraGSettingsOverrides = ''





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
  system.stateVersion = "21.11";
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  nixpkgs.config.allowUnfree = true;
}
