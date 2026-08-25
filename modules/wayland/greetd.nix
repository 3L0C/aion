# greetd display manager with tuigreet
{
  flake.modules.nixos.greetd =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      tuigreetTheme = "border=magenta;text=cyan;prompt=green;time=cyan;action=white;button=yellow;container=black;input=white";

      sessionData = config.services.displayManager.sessionData.desktops;
    in
    {
      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            # Keep the command a single-line string. For values with newlines,
            # nixpkgs' TOML generator emits a multi-line literal (''') that
            # greetd 0.10.3's TOML parser rejects.
            command = lib.concatStringsSep " " [
              (lib.getExe pkgs.tuigreet)
              "--greeting 'wake up...'"
              "--time --time-format '%Y-%m-%d %H:%M:%S'"
              "--remember --remember-session"
              "--asterisks"
              "--sessions ${sessionData}/share/wayland-sessions"
              "--theme '${tuigreetTheme}'"
            ];
            user = "greeter";
          };
        };
      };

      # Fix greetd startup race: https://github.com/apognu/tuigreet/issues/68
      systemd.services.greetd.serviceConfig = {
        Type = "idle";
      };

      users.groups.greeter = { };
      users.users.greeter = {
        isSystemUser = true;
        group = "greeter";
      };
    };
}
