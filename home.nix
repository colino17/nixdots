{ config, pkgs, ... }:

#################
### VARIABLES ###
#################

let inherit (import ./variables.nix) var_wallpaper; in

{
  environment.systemPackages = with pkgs; [
    home-manager
  ];

####################
### HOME MANAGER ###
####################
  home-manager.users.colin = { pkg, ...}: {
    programs = {
      bash = {
        enable = true;
        initExtra = "neofetch --ascii ~/.config/neofetch/halsey.txt --ascii_colors 3 2";
      };
    };
    
  home.stateVersion = "22.05";

######################
### DCONF SETTINGS ###
######################
    dconf.settings = {
      "org/gnome/settings-daemon/plugins/media-keys" = {
        "custom-keybindings" = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"
        ];
      };   
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        "binding" = "<Super>t";
        "command" = "kgx";
        "name" = "open-terminal";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        "binding" = "<Super>e";
        "command" = "nautilus";
        "name" = "open-files";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        "binding" = "<Super>w";
        "command" = "firefox";
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
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" = {
        "binding" = "<Shift>TouchpadToggle";
        "command" = "virsh start steampod";
        "name" = "steampod";
      };
      "org/gnome/desktop/wm/keybindings" = {
        "close" = [
          "<Super>q"
        ];
      };   
      "org/gnome/desktop/wm/preferences" = {
        "button-layout" = "appmenu:minimize,maximize,close";
      };
      "org/gnome/shell" = {
        "favorite-apps" = [
          "org.gnome.Nautilus.desktop"
          "firefox.desktop"
          "org.gnome.Console.desktop"
          "com.github.iwalton3.jellyfin-media-player.desktop"
          "discord.desktop"
          "com.valvesoftware.Steam.desktop"
        ];
        "disable-user-extensions" = false;
        "enabled-extensions" = [
          "places-menu@gnome-shell-extensions.gcampax.github.com"
          "trayIconsReloaded@selfmade.pl"
          "tailscale@joaophi.github.com"
          "Vitals@CoreCoding.com"
          "forge@jmmaranan.com"
          "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        ];
      };
      "org/gnome/shell/extensions/auto-move-windows" = {
          "application-list" = [
            "org.gnome.Nautilus.desktop:1"
            "org.gnome.Console.desktop:1"
            "firefox.desktop:2"
            "discord.desktop:2" 
            "com.github.iwalton3.jellyfin-media-player.desktop:3"
            "io.github.celluloid_player.Celluloid.desktop:3"
            "gimp.desktop:4"
            "com.valvesoftware.Steam.desktop:5"
          ];
      };

      "org/gnome/mutter" = {
        "edge-tiling" = true;
      };
      "org/gnome/desktop/interface" = {
        "icon-theme" = "Numix-Circle";
        "clock-format" = "12h";
        "color-scheme" = "prefer-dark";
        "show-battery-percentage" = true;
        "gtk-theme" = "Adwaita-dark";
      };
      "org/gnome/desktop/background" = {
        "picture-uri" = var_wallpaper;
        "picture-uri-dark" = var_wallpaper;
      };
      "org/gnome/desktop/sound" = {
        "allow-volume-above-100-percent" = true;
      };
      "org/gnome/nautilus/list-view" = {
        "default-visible-columns" = [
          "name"
          "size"
          "detailed_type"
          "date_modified"
        ];
      };
    };
    
################
### NEOFETCH ###
################
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
    
           ▄▄  █░█ ▄▀█ █░░ █▀ █▀▀ █▄█
           ░░  █▀█ █▀█ █▄▄ ▄█ ██▄ ░█░
    '';
    
#######################
### DESKTOP ENTRIES ###
#######################
    xdg.desktopEntries.renamer = {
          name = "Renamer";
          genericName = "Renamer";
          exec = "appimage-run /Storage/Files/Packages/APPS/renamer.AppImage";
          terminal = false;
          icon = "gprename";
    };
    
########################
### WALLPAPER FOLDER ###
########################
    home.file."Pictures/Wallpapers" = {
      source = /etc/nixos/wallpapers;
      recursive = true;
    };

  };   
}  
