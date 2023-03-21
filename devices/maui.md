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
