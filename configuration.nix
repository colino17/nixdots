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

####################
### HOME MANAGER ###
####################
  home-manager.users.colin = { pkg, ...}: {
    programs = {
      bash = {
        enable = true;
        initExtra = "neofetch";
      };
    };
    dconf.settings = {
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
        ];
      };   
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings" = {
        custom0 = {
          binding = "<Super>t";
          command = "kgx";
          name = "open-terminal";
        };
        custom1 = {
          binding = "<Super>e";
          command = "nautilus";
          name = "open-files";
        };
        custom2 = {
          binding = "<Super>w";
          command = "google-chrome-stable";
          name = "open-browser";
        };
        custom3 = {
          binding = "<Super>d";
          command = "discord";
          name = "open-discord";
        };
        custom4 = {
          binding = "<Super>g";
          command = "gimp";
          name = "open-gimp";
        };
      };
      "org/gnome/shell" = {
        "favorite-apps" = [
          "org.gnome.Nautilus.desktop"
          "google-chrome.desktop"
          "org.gnome.Console.desktop"
          "gimp.desktop"
          "discord.desktop"
          "steam.desktop"
        ];
      };
      "org/gnome/desktop/wm/keybindings" = {
        "close" = [
          "<Super>q"
        ];
      };
    };
    home.file.".config/neofetch/config.conf".text = ''
      Hello World!
    '';
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
  environment.systemPackages = with pkgs; [
    wget
    curl
#    etcher ###electron dependency currently broken on unstable channel###
    nfs-utils
    neofetch
    cmatrix
    tailscale
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
    google-chrome
    home-manager
    numix-icon-theme-circle
    celluloid
    evince
    szyszka ###this doesn't show up in gnome launcher and must be launched through the terminal###
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
