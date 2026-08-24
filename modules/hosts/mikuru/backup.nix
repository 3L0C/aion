# Weekly backup of service state to the tank pool.
# The backup logic lives in pkgs/backup-mikuru (pkgs.custom.backup-mikuru, installed
# as `mikuru-backup`). This module installs the script and schedules it.
# Run manually with `sudo mikuru-backup` or `systemctl start backup-state`.
{
  flake.modules.nixos."hosts/mikuru" = {
    lib,
    pkgs,
    ...
  }: {
    environment.systemPackages = [pkgs.custom.backup-mikuru];

    systemd = {
      services.backup-state = {
        description = "Back up mikuru service state to tank/backups/mikuru-state";
        # The script gets zfs/zpool/pg_dumpall from the host PATH, but systemd units
        # do not inherit a login PATH. Without this, the script's preflight
        # `command -v zfs` fails on every timer run.
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
          # Run at the next boot if the scheduled time was missed.
          Persistent = true;
        };
      };
    };
  };
}
