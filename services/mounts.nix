{ config, pkgs, ... }:
{

  fileSystems."/Storage/Configs" = {
    device = "10.17.10.17:/Configs";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.mount-timeout=10" "timeo=14" "x-systemd.idle-timeout=60min" ];
  };
  
  fileSystems."/Storage/Files" = {
    device = "10.17.10.17:/Files";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.mount-timeout=10" "timeo=14" "x-systemd.idle-timeout=60min" ];
  };
  
    fileSystems."/Storage/Media" = {
    device = "10.17.10.17:/Media";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.mount-timeout=10" "timeo=14" "x-systemd.idle-timeout=60min" ];
  };
  
    fileSystems."/Storage/Recordings" = {
    device = "10.17.10.17:/Recordings";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.mount-timeout=10" "timeo=14" "x-systemd.idle-timeout=60min" ];
  };

    fileSystems."/Backup/Khonsu/Media" = {
    device = "10.17.10.19:/Media";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.mount-timeout=10" "timeo=14" "x-systemd.idle-timeout=60min" ];
  };

    fileSystems."/Backup/Khonsu/Files" = {
    device = "10.17.10.19:/Files";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.mount-timeout=10" "timeo=14" "x-systemd.idle-timeout=60min" ];
  };

    fileSystems."/Backup/Khonsu/Configs" = {
    device = "10.17.10.19:/Configs";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.mount-timeout=10" "timeo=14" "x-systemd.idle-timeout=60min" ];
  };

}
