{
  flake.modules.nixos.maintenance = { pkgs, ... }: {
    services.irqbalance.enable = true;
    systemd = {
      services.journalctl-vacuum = {
        description = "Vacuum journalctl logs";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.systemd}/bin/journalctl --vacuum-time=23d";
        };
      };
      timers.journalctl-vacuum = {
        wantedBy = [ "timers.target" ];
        partOf = [ "journalctl-vacuum.service" ];
        timerConfig.OnCalendar = "weekly";
      };

      services.irqbalance.serviceConfig.ProtectKernelTunables = "no";
    };
  };
}
