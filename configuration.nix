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
        initExtra = "neofetch --ascii ~/.config/neofetch/halsey.txt --ascii_colors 3 2
";
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
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>t";
        command = "kgx";
        name = "open-terminal";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        "binding" = "<Super>e";
        "command" = "nautilus";
        "name" = "open-files";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        "binding" = "<Super>w";
        "command" = "google-chrome-stable";
        "name" = "open-browser";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
        "binding" = "<Super>d";
        "command" = "discord";
        "name" = "open-discord";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
        "binding" = "<Super>g";
        "command" = "gimp";
        "name" = "open-gimp";
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
      print_info() {
          info "System" distro
          info "Kernel" kernel
          info "Environment" de
          info "Uptime" uptime
          info "Packages" packages
          info "CPU" cpu
          info "GPU" gpu
          info "Memory" memory
          info "Disk" disk
          info "Local IP" local_ip
          info "Public IP" public_ip

          info cols
      }

      distro_shorthand="off"
      os_arch="off"
      uptime_shorthand="tiny"
      package_managers="off"
      public_ip_host="https://ident.me"
      de_version="on"
      disk_subtitle="none"
      colors=(distro)
      separator=" =="
      ascii_distro="auto"
      ascii_colors=(distro)
      image_size="auto"
      
      # Distros: auto, NixOS, OpenSUSE, Raspbian, GalliumOS, LFS, macos, Trisquel, openSUSE_Tumbleweed, steamos, SmartOS, SalentOS, Radix, Proxmox, Peppermint, Minix
      # Ascii Colors: (distro) or (4 6 1 8 8 6)
      # Image size:  'auto', '00px', '00%', 'none'
    '';
    home.file.".config/neofetch/halsey.txt".text = ''
     █ ▀ █▀▄▀█   █▄░█ █▀█ ▀█▀  
     █ ░ █░▀░█   █░▀█ █▄█ ░█░  
    
     ▄▀█   █▀▄▀█ ▄▀█ █▀█ ▀█▀ █▄█ █▀█  
     █▀█   █░▀░█ █▀█ █▀▄ ░█░ ░█░ █▀▄  
    
     █ ▀ █▀▄▀█   ▄▀█  
     █ ░ █░▀░█   █▀█  
    
     █▀█ █▀█ █▀█ █▄▄ █░░ █▀▀ █▀▄▀█
     █▀▀ █▀▄ █▄█ █▄█ █▄▄ ██▄ █░▀░█
    
       ${c1}  ▄▄  █░█ ▄▀█ █░░ █▀ █▀▀ █▄█
         ░░  █▀█ █▀█ █▄▄ ▄█ ██▄ ░█░
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
