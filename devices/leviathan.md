```
sudo fdisk /dev/sda
o
n
default
default
default
w
```

```
sudo mkfs.ext4 -L nixos /dev/sda1
```

```
sudo mount /dev/disk/by-label/nixos /mnt
sudo nixos-generate-config --root /mnt
sudo nano /mnt/etc/nixos/configuration.nix
```

```
  boot.loader.grub.device = "/dev/sda";

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

```
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
