{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_username; in

{
  imports =
    [
      ../services/base.nix
#      ../services/cad.nix
#      ../services/easyeffects.nix
#      ../services/flatpak.nix
#      ../services/gnome.nix
#      ../services/media.nix
      ../services/utilities.nix
      ../services/web.nix
#      ../services/vpn.nix
#      ../services/adb.nix
      ../services/sound.nix
#      ../services/uefi.nix
      ../bios.nix
#      ../services/printing.nix
#      ../services/mounts.nix
      ../services/virt-viewer.nix
#      ../services/x2go.nix
      ../users/${var_username}.nix
#      ../home.nix
    ];
    
  networking = {
    interfaces.eth0.wakeOnLan.enable = true;
    hostName = "cerberus";
  };

##################
## HOME MANAGER ##
##################

  home-manager.users.${var_username} = { pkg, ...}: {
    programs = {
      bash = {
        enable = true;
        initExtra = "fastfetch -c ~/.config/fastfetch/config.jsonc -l none";
      };
    };
    
  home.stateVersion = "22.05";

    home.file.".config/fastfetch/config.jsonc".text = ''
      {
          "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
          "logo": {
              "padding": {
                  "top": 0
              }
          },
          "modules": [
              {
                  "type": "os",
                  "key": "System",
                  "format": "{3}"
              },
              "kernel",
              {
                  "type": "de",
                  "key": "Environment",
                  "format": "{2} {3}"
              },
              "uptime",
              "packages",
              {
                  "type": "cpu",
                  "key": "CPU",
                  "format": "{1} ({3} cores / {5} threads)",
                  "folders": "/"
              },
              {
                  "type": "gpu",
                  "key": "GPU",
                  "format": "{1} {2}",
                  "folders": "/"
              },
              "memory",
              {
                  "type": "disk",
                  "key": "Storage",
                  "format": "{1} / {2} ({3} used)",
                  "folders": "/"
              },
              {
                  "type": "localip",
                  "key": "Local IP",
                  "format": "{1}"
              },
              {
                  "type": "publicip",
                  "key": "Public IP",
                  "format": "{1}"
              },
              {
                  "type": "datetime",
                  "key": "Date",
                  "format": "{5} {11}, {1} at {14}:{18}:{20}"
              },
              "break",
              "colors"
          ]
      }
    '';
  };         
###########
## GNOME ##
###########
  services.xserver.displayManager = {
    autoLogin = {
      enable = true;
      user = "${var_username}";
    }; 
  };

  # Workaround for Current Gnome Bug
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  services.gnome.core-utilities.enable = false;
  services.dbus.packages = [ pkgs.dconf ];
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome-system-monitor
    gnome-console
    eog
    gnome-tweaks
    dconf-editor
    gnome-text-editor
    nautilus
    file-roller
    celluloid
    evince
    home-manager
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
  ];



##########################
### VERSION AND REBOOT ###
##########################
system.autoUpgrade.allowReboot = false;

}
