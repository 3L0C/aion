{
  config,
  lib,
  pkgs,
  ...
}: let
  swaylock = "${config.programs.swaylock.package}/bin/swaylock";
  loginctl = "${pkgs.systemd}/bin/loginctl";

  baseTimeout = 900; # 15 minutes
in {
  services.swayidle = {
    enable = true;
    systemdTarget = "river-session.target";

    events = [
      {
        event = "before-sleep";
        command = "${loginctl} lock-session";
      }
      {
        event = "after-resume";
        command = "${pkgs.wlopm}/bin/wlopm --on \\*";
      }
    ];

    timeouts = [
      {
        timeout = baseTimeout;
        command = "${loginctl} lock-session";
      }
      {
        timeout = baseTimeout + 60;
        command = "${pkgs.wlopm}/bin/wlopm --off \\*";
        resumeCommand = "${pkgs.wlopm}/bin/wlopm --on \\*";
      }
    ];
  };
  systemd.user.services.swayidle = {
    Unit = {
      PartOf = ["river-session.target"];
      After = ["river-session.target"];
    };
    Install = {
      WantedBy = lib.mkForce ["river-session.target"];
    };
  };
  systemd.user.services.swaylock = {
    Unit = {
      Description = "Screen locker for River";
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${swaylock} --daemonize";
      Restart = "on-failure";
    };
  };
}
