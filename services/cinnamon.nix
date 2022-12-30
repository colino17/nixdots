{ config, pkgs, ... }:

{

  services.cinnamon.apps.enable = false;
  services.dbus.packages = [ pkgs.dconf ];
  
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.cinnamon = {
      enable = true;
      extraGSettingsOverrides = ''
        [org.cinnamon.theme]
        name = "Mint-Y-Dark-Blue"
        [org.cinnamon.desktop.interface]
        clock-use-24h = false
        gtk-theme = "Mint-Y-Dark-Blue"
        icon-theme = "Mint-Y-Dark-Blue"
        [org.nemo.desktop]
        home-icon-visible = false
        computer-icon-visible = false
        volumes-visible = false
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    gnome-console
    blueberry
    gnome.file-roller
    gnome.gnome-disk-utility
    xed-editor
    celluloid
  ];
   
}
