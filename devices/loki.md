## Turn on BIOS Settings
Enable "IOMMU" and "SVM" in the BIOS.
Set GT710 slot as primary GPU.

## Install NixOS...
Complete the partitioning and install NixOS 22.05 using the new GUI installer.

## Add packages to config...
```
sudo nano /mnt/etc/nixos/configuration.nix
```

```
  environment.systemPackages = with pkgs; [
    wget
    rsync
    unzip
  ];
```

```
sudo nixos-rebuild switch
sudo reboot
```

## Download configs from Github...
```
cd /etc/nixos
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
      ./devices/loki.nix
    ];
```

## Rebuild config...
```bash
sudo nixos-rebuild switch
```

## Start Tailscale...
```bash
sudo tailscale up
sudo reboot
```

## Setup VM in Virt-Manager