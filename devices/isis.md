# ISIS - Backup NAS Server

## Partition Disks
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

## Format Disks
```bash
sudo mkfs.fat -F 32 -n boot /dev/sda1
sudo mkfs.ext4 -L nixos /dev/sda2
```

## Install NixOS
```bash
sudo mount /dev/disk/by-label/nixos /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/boot /mnt/boot
```

## Generate initial config...
```bash
sudo nixos-generate-config --root /mnt
```

## Add packages to initial config...
```bash
sudo nano configuration.nix
```
```nix
  boot.loader.systemd-boot.enable = true;
   boot.loader.efi.efiSysMountPoint = "/boot/efi";

...

  environment.systemPackages = with pkgs; [
    wget
    rsync
    unzip
  ];
```

## Finish Install...
```bash
sudo nixos-install
reboot
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
