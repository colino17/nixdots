{ config, pkgs, ... }:

{
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
    
##################
### WALLPAPERS ###
##################
    home.file.".nixdots".source = fetchFromGitHub {
      owner = "colino17";
      repo = "nixos-configs";
      rev = "main";
    };

######################
### DCONF SETTINGS ###
######################
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
      "org/gnome/desktop/wm/keybindings" = {
        "close" = [
          "<Super>q"
        ];
      };     
      "org/gnome/shell" = {
        "favorite-apps" = [
          "org.gnome.Nautilus.desktop"
          "firefox.desktop"
          "org.gnome.Console.desktop"
          "gimp.desktop"
          "discord.desktop"
          "steam.desktop"
        ];
        "enabled-extensions" = [
          "places-menu@gnome-shell-extensions.gcampax.github.com"
        ];
      };
      "org/gnome/mutter" = {
        "edge-tiling" = true;
      };
      "org/gnome/desktop/background" = {
        "picture-uri" = "/home/colin/.nixdots/wallpapers/beach.jpg";
      };
      "org/gnome/desktop/screensaver" = {
        "picture-uri" = "/home/colin/.nixdots/wallpapers/beach.jpg";
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
  };   

}  
