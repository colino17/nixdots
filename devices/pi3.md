# CERBERUS
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
sudo chmod +x update.sh
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
