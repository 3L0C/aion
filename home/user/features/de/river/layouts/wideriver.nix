{
  lib,
  pkgs,
  ...
}: let
  mod = "Super";
  layoutmsg = msg: "send-layout-cmd wideriver \"${msg}\"";
in {
  home.packages = [pkgs.wideriver];
  systemd.user.services.wideriver = lib.custom.mkWaylandService "river" {
    Unit = {
      Description = "Wideriver layout daemon for River";
      Documentation = "https://github.com/alex-courtis/wideriver";
    };

    Service = {
      Type = "simple";
      ExecStart = toString [
        "${lib.getExe pkgs.wideriver}"
        "--layout                       left"
        "--layout-alt                   monocle"
        "--stack                        dwindle"
        "--count-master                 1"
        "--ratio-master                 0.60"
        "--count-wide-left              0"
        "--ratio-wide                   0.35"
        "--no-smart-gaps"
        "--inner-gaps                   10"
        "--outer-gaps                   20"
        "--border-width                 4"
        "--border-width-monocle         4"
        "--border-width-smart-gaps      4"
        "--border-color-focused         \"\""
        "--border-color-focused-monocle \"\""
        "--border-color-unfocused       \"\""
        "--log-threshold                info"
      ];
      Restart = "on-failure";
      RestartSec = "3s";
    };
  };

  wayland.windowManager.river = {
    settings = {
      default-layout = lib.mkForce "wideriver"; # namespace

      map.normal = {
        "${mod} Y" = layoutmsg "--layout left --stack dwindle";
        "${mod} I" = layoutmsg "--layout monocle";
        "${mod} T" = layoutmsg "--layout top --stack even";
      };
    };
  };
}
