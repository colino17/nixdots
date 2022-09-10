{ config, pkgs, ... }:
{

  fileSystems."/Storage" = {
    device = "10.17.10.17:/Storage";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.mount-timeout=10" "timeo=14" "x-systemd.idle-timeout=60min" ];
  };
  
  fileSystems."/CCTV" = {
    device = "10.17.10.17:/CCTV";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.mount-timeout=10" "timeo=14" "x-systemd.idle-timeout=60min" ];
  };

}
