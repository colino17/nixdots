{ config, pkgs, ... }:
{

  hardware.sane. = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
    disabledDefaultBackends = [ "escl" ];
    openFirewall = true;
  };

  services.udev.packages = [ pkgs.sane-airscan ];
  services.saned.enable = true;

  environment.systemPackages = with pkgs; [
    simple-scan
  ];

}
