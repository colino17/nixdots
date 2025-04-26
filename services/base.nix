{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_username var_stateversion; in

{
  nixpkgs.config.allowUnfree = true;
  documentation.nixos.enable = false;
  environment.systemPackages = with pkgs; [
    wget
    curl
    rsync
    unzip
    git
    nfs-utils
    usbutils
    pciutils
    lm_sensors
    yt-dlp
    internetarchive
    ffmpeg
    cmatrix
    e2fsprogs
    iperf
    tmux
    fastfetch
  ];

## IPERF SETTINGS ##
  networking.firewall.allowedTCPPorts = [ 5201 ];

## FASTFETCH SETTINGS ##
  home-manager.users.${var_username} = { config, ... }: {
    home.stateVersion = "${var_stateversion}";
    programs.bash = {
      enable = true;
      initExtra = "fastfetch -c ~/.config/fastfetch/config.jsonc -l none";
    };
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

}
