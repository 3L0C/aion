{
  pkgs,
  lib,
  config,
  ...
}: let
  tuigreetTheme = "border=magenta;text=cyan;prompt=green;time=cyan;action=white;button=yellow;container=black;input=white";

  sessionData = config.services.displayManager.sessionData.desktops;
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${lib.getExe pkgs.tuigreet} \
          --time --time-format '%Y-%m-%d %H:%M:%S' \
          --remember --remember-session \
          --asterisks \
          --sessions ${sessionData}/share/wayland-sessions \
          --theme '${tuigreetTheme}'
        '';
        user = "greeter";
      };
    };
  };
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
  };
  users.groups.greeter = {};
  users.users.greeter = {
    isSystemUser = true;
    group = "greeter";
  };
}
