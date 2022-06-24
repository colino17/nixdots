{ config, pkgs, ... }:
{

  fileSystems."/Storage" = {
    device = "192.168.0.17:/Storage";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.mount-timeout=10" "timeo=14" "x-systemd.idle-timeout=1min" ];
  };

  fileSystems."/Backup" = {
    device = "192.168.0.18:/Backup";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.mount-timeout=10" "timeo=14" "x-systemd.idle-timeout=1min" ];
  };
  
  fileSystems."/CCTV" = {
    device = "192.168.0.17:/CCTV";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.mount-timeout=10" "timeo=14" "x-systemd.idle-timeout=1min" ];
  };

}
