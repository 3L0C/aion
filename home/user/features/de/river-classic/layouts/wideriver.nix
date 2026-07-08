{
  config,
  lib,
  pkgs,
  ...
}: let
  riverctl = "${lib.getExe' pkgs.river-classic "riverctl"}";
  mod = config.userSpec.modifierKeys.river-classic;
  layoutmsg = msg: "send-layout-cmd wideriver \"${msg}\"";
  layoutSettingsScript = pkgs.writeShellScript "river-layout-settings" ''
    ${riverctl} default-layout wideriver
  '';
  layoutKeybindingsScript = lib.custom.mkRiverBindsScript pkgs "river-layout-keybindings" {
    bindings = [
      "${mod} Y ${layoutmsg "--layout left --stack dwindle"}"
      "${mod} I ${layoutmsg "--layout monocle"}"
      "${mod} T ${layoutmsg "--layout top --stack even"}"
    ];
  };
in {
  home.packages = [pkgs.wideriver];
  systemd.user.services = {
    wideriver = lib.custom.mkWaylandService {
      riverclassic = {
        Unit = {
          Description = "Wideriver layout daemon for River Classic";
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
            "--border-color-focused         \"0x${config.lib.stylix.colors.base0D}\""
            "--border-color-focused-monocle \"0x${config.lib.stylix.colors.base0D}\""
            "--border-color-unfocused       \"0x${config.lib.stylix.colors.base04}\""
            "--log-threshold                info"
          ];
          Restart = "on-failure";
          RestartSec = "3s";
        };
      };
    };
    river-layout-settings = lib.custom.mkWaylandService {
      riverclassic = {
        Unit = {
          Description = "River Classic layout settings";
          Documentation = "man:riverctl(1)";
          After = ["wideriver.service"];
        };

        Service = {
          Type = "oneshot";
          ExecStart = layoutSettingsScript;
          RemainAfterExit = true;
        };
      };
    };
    river-layout-keybindings = lib.custom.mkWaylandService {
      riverclassic = {
        Unit = {
          Description = "River Classic layout keybindings";
          Documentation = "man:riverctl(1)";
          After = ["river-keybindings.service"];
        };

        Service = {
          Type = "oneshot";
          ExecStart = layoutKeybindingsScript;
          RemainAfterExit = true;
        };
      };
    };
  };
}
