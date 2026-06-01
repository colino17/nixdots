{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    freecad
  ];

  security.pki.certificateFiles = [
    /Storage/Configs/bambuddy/bambuddy-virtual-printer-ca.crt
  ];
}
