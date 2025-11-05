{
  lib,
  pkgs,
  ...
}: let
  loginctl = "${pkgs.systemd}/bin/loginctl";

  baseTimeout = 900; # 15 minutes
in {
  services.swayidle = {
    enable = true;
    systemdTarget = "wayland-session@river.target";

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
      systemdTarget = "wayland-session@river.target";
      PartOf = ["wayland-session@river.target"];
      After = ["wayland-session@river.target"];
    };
    Install = {
      WantedBy = lib.mkForce ["wayland-session@river.target"];
    };
  };
}
