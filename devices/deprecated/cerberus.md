# CERBERUS - VPN and DNS Adblocker
- Machine type: Raspberry Pi B+
- Wiki entry here: https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi_3
- Write AARCH64 image to SD card: https://hydra.nixos.org/job/nixos/release-21.11/nixos.sd_image.aarch64-linux
- Information on Tailscale subnets here: https://tailscale.com/kb/1019/subnets/

## Generate initial config...
```bash
cd /etc/nixos
sudo nixos-generate-config
```

## Add packages to initial config...
```bash
sudo nano configuration.nix
```
```nix
  environment.systemPackages = with pkgs; [
    wget
    rsync
    unzip
  ];
```

## Rebuild config...
```bash
sudo nixos-rebuild switch
```

## Pull update script and run to update config...
```bash
sudo wget https://raw.githubusercontent.com/colino17/nixdots/main/update.sh
sudo sh update.sh
```

## Choose device in configuration...
```bash
sudo configuration.nix
```
```nix
  imports =
    [
      ./hardware-configuration.nix
      ./devices/cerberus.nix
    ];
```

## Rebuild config...
```bash
sudo nixos-rebuild switch
```

## Set passwords...
```bash
sudo passwd root
sudo passwd colin
sudo reboot
```

## Start Tailscale...
```bash
sudo tailscale up --advertise-routes=192.168.0.0/24
sudo reboot
```

## Edit config.txt...
Either "hdmi_force_hotplug=1" or "hdmi_safe=1" need to be added manually to the config.txt file in the FIRMWARE partition. This is supposed to be declared in the configuration.nix file using the snippet below, but the firmwareConfig option is currently broken.

```nix
  boot.loader.raspberryPi.firmwareConfig = ''
    hdmi_force_hotplug=1
  '';
```
Without this change the Pi will not boot unless an HDMI output is plugged in.
