# ANUBIS - NVR Server

## Partition Boot Disks...
```bash
lsblk
sudo fdisk /dev/nvme0n1
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
sudo fdisk /dev/sda
d
w
sudo wipefs -a -f /dev/sda
```

## Format Boot Disks...
```bash
sudo mkfs.fat -F 32 -n boot /dev/nvme0n1p1
sudo mkfs.btrfs -L nixos /dev/nvme0n1p2
```

## Format Storage Disk...
```bash
sudo mkfs.btrfs -L storage /dev/sda
```

## Create Boot Disk Subvolumes...
```bash
sudo mount /dev/disk/by-label/nixos /mnt
sudo btrfs subvolume create /mnt/root
sudo umount /mnt
```

## Create Storage Disk Subvolumes...
```bash
sudo mount /dev/disk/by-label/storage /mnt
sudo btrfs subvolume create /mnt/Configs
sudo btrfs subvolume create /mnt/CCTV
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
```bash
sudo configuration.nix
```
```nix
  imports =
    [
      ./hardware-configuration.nix
      ./devices/anubis.nix
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

## Start Tailscale...
```bash
sudo tailscale up --advertise-routes=10.17.10.0/24
sudo reboot
```
