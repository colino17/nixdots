{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # BOOTLOADER - BIOS
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # TIMEZONE
  time.timeZone = "Canada/Atlantic";

  # NETWORKING
  networking.useDHCP = false;
  networking.interfaces.enp12s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.hostName = "nixos";



  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };


  # GNOME DESKTOP
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";
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


  # Enable CUPS to print documents.
  # services.printing.enable = true;
  

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # SOUND
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


  # USERS
  users.users.colino17 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
};

  # PACKAGES
  environment.systemPackages = with pkgs; [
  # Base
    wget
    curl
    htop
    nfs-utils
    neofetch
    cmatrix
  # Media
    youtube-dl
    mpv
    ffmpeg
  # Web
    google-chrome
    discord
  # System
    baobab
    gnome.gnome-system-monitor
    gnome.gnome-terminal
    gnome.eog
  # Editors
    vscodium
    gimp
  # File Management
    gnome.nautilus
    gnome.file-roller
    szyszka
  ];
  
  # STEAM SUPPORT
  programs.steam.enable = true;
    
  # SSH SUPPORT
  services.openssh.enable = true;

 # SYSTEM VERSION AND UPDATES
  system.stateVersion = "21.11"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  nixpkgs.config.allowUnfree = true;
