{ config, lib, pkgs, ... }:

let
  certDir = "/Storage/Configs/bambuddy";
  bundle  = "${certDir}/printer.cer";
  slicers = {
    "com.bambulab.BambuStudio" = "BambuStudio";
    "com.orcaslicer.OrcaSlicer" = "OrcaSlicer";
  };
  appRoot = id: "/var/lib/flatpak/app/${id}";
in
{

  environment.systemPackages = [ pkgs.freecad ];

  systemd.tmpfiles.rules = lib.concatLists (lib.mapAttrsToList (id: dir: [
    # FLATPAK PERMISSIONS TO READ THE CERTIFICATE DIRECTORY
    "f+ /var/lib/flatpak/overrides/${id} 0644 root root - [Context]\\nfilesystems=${certDir}:ro;\\n"
    # REPLACE BAMBU/ORCA CA PATHS WITH STORED CERT
    "L+ ${appRoot id}/current/active/files/share/${dir}/cert/printer.cer - - - - ${bundle}"
  ]) slicers);

  # REAPPLY THE ABOVE RULES AFTER FLATPAK UPDATES
  systemd.services.slicer-certs = {
    description = "Re-apply Bambuddy CA bundle to flatpak slicers";
    unitConfig.RequiresMountsFor = certDir;
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${config.systemd.package}/bin/systemd-tmpfiles --create --prefix=/var/lib/flatpak";
    };
  };

  systemd.paths.slicer-certs = {
    wantedBy = [ "multi-user.target" ];
    pathConfig = {
      Unit = "slicer-certs.service";
      PathChanged = lib.mapAttrsToList (id: _: "${appRoot id}/x86_64/stable") slicers;
    };
  };

}
