# MAUI - SteamOS GameBox

## Partition Boot Disk...
```bash
lsblk
sudo fdisk /dev/sda
o
n
p
default
default
default
a
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
sudo mkfs.btrfs -L nixos /dev/sda1
```

## Format Backup Disks...
```bash
sudo mkfs.btrfs -L backup -m raid1 -d single /dev/sdb /dev/sdc
```

## Create Boot Disk Subvolumes...
```bash
sudo mount /dev/disk/by-label/nixos /mnt
sudo btrfs subvolume create /mnt/root
sudo btrfs subvolume create /mnt/Games
sudo umount /mnt
```

## Create Backup Disk Subvolumes...
```bash
sudo mount /dev/disk/by-label/backup /mnt
sudo btrfs subvolume create /mnt/Files
sudo btrfs subvolume create /mnt/Media
sudo umount /mnt
```

## Mount Disks...
```bash
sudo mount -o compress=zstd,subvol=root /dev/disk/by-label/nixos /mnt
```

## Generate Config and Install...
```bash
sudo nixos-generate-config --root /mnt
```

## Add packages to config...
```
sudo nano /mnt/etc/nixos/configuration.nix
```

```
  boot.loader.grub.device = /dev/sda
  environment.systemPackages = with pkgs; [
    wget
    rsync
    unzip
  ];
```

```
sudo nixos-install
sudo reboot
```

## Download configs from Github...
```
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
      ./devices/maui.nix
    ];
```

## Rebuild config...
```bash
sudo nixos-rebuild switch
```

## PS2 GAMES
### PCSX2 Settings
- General > BIOS > Set Path
- General > Folders > Cheats
- General > GS Window > Aspect Ratio > 16:9
- General > GS Window > Fullscreen
- Graphics > Renderer > Internal Resolution > 1080p
- Gamepad > Gamepad Configuration > Dualshock 4
### Add to Steam
- Launch Parameter = "pcsx2 path/to/game/iso"
- Add custom artwork, custom background, and custom logo
- Disable Steam Input

## GAMECUBE GAMES
### Dolphin Settings
- Graphics > General > Resolution > 1080
- Graphics > General > Fullscreen
- Graphics > Enhancements > Internal Resolution > 3xNative
### Add to Steam
- Launch Parameter = "dolphin-emu --batch --exec=/path/to/game/iso"
- Add custom artwork, custom background, and custom logo


## SNES GAMES
### snes9x-gtk Settings
- Fullscreen
- Setup Gamepad
- Turn on Scanlines
### Add to Steam
- Launch Parameter = "snes9x-gtk /path/to/game/rom"
- Add custom artwork, custom background, and custom logo
- Disable Steam Input
