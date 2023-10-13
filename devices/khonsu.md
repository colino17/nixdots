# KHONSU - Backup Server

## Partition Boot Disks...
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

## Remove Partitions on Storage Disks...
```bash
lsblk
sudo fdisk /dev/sdb
d
w
sudo wipefs -a -f /dev/sdb
```

```bash
lsblk
sudo fdisk /dev/sdc
d
w
sudo wipefs -a -f /dev/sdc
```

## Format Boot Disks...
```bash
sudo mkfs.fat -F 32 -n boot /dev/sda1
sudo mkfs.btrfs -L nixos /dev/sda2
```

## Format Backup Disks...
```bash
sudo mkfs.btrfs -L backup -m raid1 -d raid1 /dev/sdb /dev/sdc
```

## Create Boot Disk Subvolumes...
```bash
sudo mount /dev/disk/by-label/nixos /mnt
sudo btrfs subvolume create /mnt/root
sudo umount /mnt
```

## Create Storage Disk Subvolumes...
```bash
sudo mount /dev/disk/by-label/backup /mnt
sudo btrfs subvolume create /mnt/Backup
sudo umount /mnt
```

## Mount Disks...
```bash
sudo mount -o compress=zstd,subvol=root /dev/disk/by-label/nixos /mnt
sudo mkdir -p /mnt/boot/efi
sudo mount /dev/disk/by-label/boot /mnt/boot/efi
```

## Generate Config and Install...
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
```nix
  imports =
    [
      ./hardware-configuration.nix
      ./devices/khonsu.nix
    ];
```

## Rebuild config...
```bash
sudo nixos-rebuild boot
reboot
```

## Set passwords...
```bash
sudo passwd colin
sudo reboot
```
## Start Tailscale...
```bash
sudo tailscale up -ssh
sudo reboot
```
