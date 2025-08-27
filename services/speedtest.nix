{ config, pkgs, ... }:

{
# SPEEDTEST RECURRING TEST
  systemd.services.speedtest = {
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.speedtest-go}/bin/speedtest-go --json > /Storage/Configs/hass/extras/speedtest'";  
    };
  };
  systemd.timers.speedtest = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "30m";
      Unit = "speedtest.service";
    };
  };
}
