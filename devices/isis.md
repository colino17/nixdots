# ISIS - Backup NAS Server

## Partition Disks...
```bash
lsblk
fdisk /dev/sda
g
n
default
default
+512M
n
default
default
default
t
1
1
w
```

## Format Disks...
```bash
sudo mkfs.fat -F 32 -n boot /dev/sda1
sudo mkfs.ext4 -L nixos /dev/sda2
```

## Install NixOS...
```bash
sudo mount /dev/disk/by-label/nixos /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/boot /mnt/boot
```

## Generate initial config and install...
```bash
sudo nixos-generate-config --root /mnt
sudo nixos-install
reboot
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

```bash
sudo nixos-rebuild switch
```

## Pull update script and run to update config...
```bash
cd /etc/nixos
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
      ./devices/isis.nix
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
