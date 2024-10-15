# OSIRIS - NAS Server

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

```bash
lsblk
sudo fdisk /dev/nvme1n1
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
```

```bash
lsblk
sudo fdisk /dev/sdb
d
w
```

```bash
lsblk
sudo fdisk /dev/sdc
d
w
```

## Format Boot Disks...
```bash
sudo mkfs.fat -F 32 -n boot /dev/nvme0n1p1
sudo mkfs.btrfs -L nixos -m raid1 -d raid1 /dev/nvme0n1p2 /dev/nvme1n1p2
```

## Format Recordings Disk...
```bash
sudo mkfs.btrfs -L recordings /dev/sda
```

## Format Storage Disks...
```bash
sudo mkfs.btrfs -L storage -m raid1 -d raid1 /dev/sdb /dev/sdc
```

## Create Boot Disk Subvolumes...
```bash
sudo mount /dev/disk/by-label/nixos /mnt
sudo btrfs subvolume create /mnt/root
sudo btrfs subvolume create /mnt/Configs
sudo umount /mnt
```

## Create Storage Disk Subvolumes...
```bash
sudo mount /dev/disk/by-label/storage /mnt
sudo btrfs subvolume create /mnt/Files
sudo btrfs subvolume create /mnt/Media
sudo btrfs subvolume create /mnt/Snapshots
sudo umount /mnt
```


## Create Storage Disk Subvolumes...
```bash
sudo mount /dev/disk/by-label/recordings /mnt
sudo btrfs subvolume create /mnt/Recordings
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
sudo variables.nix
```
```nix
{
  var_wallpaper = "/home/colin/Pictures/Wallpapers/1080/triangles.png";
  var_hmversion = "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
  var_hostname = "osiris";
}
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
sudo tailscale up
sudo reboot
```
