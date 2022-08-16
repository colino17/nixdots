# ISIS - Backup NAS Server

## Partition Disks...
```bash
lsblk
sudo fdisk /dev/sda
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
sudo mkdir -p /mnt/boot/efi
sudo mount /dev/disk/by-label/boot /mnt/boot/efi
```

## Generate initial config and install...
```bash
sudo nixos-generate-config --root /mnt
```

```bash
sudo nano /mnt/etc/nixos/configuration.nix
```

```nix
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  ...
  environment.systemPackages = with pkgs; [
    wget
    rsync
    unzip
  ];
```

```bash
sudo nixos-install
reboot
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
sudo nixos-rebuild boot
reboot
```

## Set passwords...
```bash
sudo passwd root
sudo passwd colin
sudo reboot
```