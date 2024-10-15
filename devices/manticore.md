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
  var_hostname = "manticore";
}
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
