{
  lib,
  pkgs,
  ...
}: let
  lock = "${pkgs.swaylock}/bin/swaylock --daemonize; ${pkgs.systemd}/bin/loginctl lock-session";
  display = status: "${pkgs.wlopm}/bin/wlopm --${status} \\*";
  displayTimeout = 120; # 2 minutes
  lockTimeout = 3600; # 1 hr
in {
  services.swayidle = {
    enable = true;
    systemdTarget = "wayland-session@river.target";

    events = {
      before-sleep = (display "off") + "; " + lock;
      after-resume = display "on";
    };

    timeouts = [
      # Display off
      {
        timeout = displayTimeout;
        command = display "off";
        resumeCommand = display "on";
      }
      # Lock 60 seconds after display off
      {
        timeout = lockTimeout;
        command = lock;
      }
    ];
  };
  systemd.user.services.swayidle = lib.custom.scopeServiceToWaylandSession "river" {};
}
