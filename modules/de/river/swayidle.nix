{config, ...}: let
  lib' = config.flake.lib;
in {
  flake.modules.homeManager.river = {pkgs, ...}: let
    lock = "${pkgs.swaylock}/bin/swaylock --daemonize; ${pkgs.systemd}/bin/loginctl lock-session";
    display = status: "${pkgs.wlopm}/bin/wlopm --${status} \\*";
    # 2 minutes
    displayTimeout = 120;
    # 1 hr
    lockTimeout = 3600;
  in {
    services.swayidle = {
      enable = true;
      systemdTargets = [""];

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

    systemd.user.services.swayidle = lib'.mkWaylandService {
      river = {};
    };
  };
}
