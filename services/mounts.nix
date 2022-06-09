{ config, pkgs, ... }:
{

  filesystems."/Storage" = {
    device = "192.168.0.17:/Storage";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.mount-timeout=10" "timeo=14" "x-systemd.idle-timeout=1min" ];
  };

  filesystems."/Backup" = {
    device = "192.168.0.17:/Backup";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.mount-timeout=10" "timeo=14" "x-systemd.idle-timeout=1min" ];
  };
  
  filesystems."/CCTV" = {
    device = "192.168.0.17:/CCTV";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.mount-timeout=10" "timeo=14" "x-systemd.idle-timeout=1min" ];
  };

}
