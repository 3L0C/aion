{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.custom.backup-mikuru];

  systemd = {
    services.backup-state = {
      description = "Back up mikuru service state to tank/backups/mikuru-state";
      path = ["/run/current-system/sw"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = lib.getExe pkgs.custom.backup-mikuru;
      };
    };

    timers.backup-state = {
      description = "Weekly mikuru service-state backup";
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = "Sun 04:00";
        Persistent = true;
      };
    };
  };
}
