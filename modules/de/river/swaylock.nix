{
  flake.modules.homeManager.river =
    {
      config,
      lib,
      ...
    }:
    {
      programs.swaylock = {
        enable = true;

        settings = {
          ignore-empty-password = true;
          show-failed-attempts = true;
          show-keyboard-layout = false;

          indicator-radius = 100;
          indicator-thickness = 10;

          image = lib.mkDefault config.userSpec.theme.wallpaper;
          scaling = "fill";

          daemonize = false;
        };
      };
    };
}
