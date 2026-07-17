{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    freecad
  ];

  systemd.tmpfiles.rules = [
    "L+ /var/lib/flatpak/app/com.bambulab.BambuStudio/current/active/files/share/BambuStudio/cert/printer.cer - - - - /Storage/Configs/bambuddy/printer.cer"
    "L+ /var/lib/flatpak/app/com.orcaslicer.OrcaSlicer/current/active/files/share/OrcaSlicer/cert/printer.cer - - - - /Storage/Configs/bambuddy/printer.cer"
  ];

}
