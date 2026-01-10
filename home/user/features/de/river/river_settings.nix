{
  config,
  lib,
  pkgs,
  ...
}: let
  riverctl = "${lib.getExe' pkgs.river-classic "riverctl"}";
  settingsScript = pkgs.writeShellScript "river-settings" ''
    ${riverctl} default-attach-mode top
    ${riverctl} allow-tearing disabled
    ${riverctl} border-width 4
    ${riverctl} focus-follows-cursor normal
    ${riverctl} hide-cursor timeout 5000
    ${riverctl} hide-cursor when-typing enabled
    ${riverctl} set-cursor-warp on-output-change
    ${riverctl} set-repeat 50 300
    ${riverctl} xcursor-theme "${config.stylix.cursor.name}" ${toString config.stylix.cursor.size}
  '';
in {
  systemd.user.services.river-settings = lib.custom.mkWaylandService {
    river = {
      Unit = {
        Description = "River compositor settings";
        Documentation = "man:riverctl(1)";
      };

      Service = {
        Type = "oneshot";
        ExecStart = settingsScript;
        RemainAfterExit = true;
      };
    };
    riverdev = {
      Unit = {
        Description = "River compositor settings";
        Documentation = "man:riverctl(1)";
      };

      Service = {
        Type = "oneshot";
        ExecStart = settingsScript;
        RemainAfterExit = true;
      };
    };
  };
}
