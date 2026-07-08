{
  config,
  lib,
  ...
}: {
  programs.swaylock = {
    enable = true;

    settings = {
      # Behavior
      ignore-empty-password = true;
      show-failed-attempts = true;
      show-keyboard-layout = false;
      indicator-radius = 100;
      indicator-thickness = 10;
      image = lib.mkDefault config.userSpec.theme.wallpaper; # Reuse the userSpec wallpaper (mkDefault: stylix may also target swaylock)
      scaling = "fill";
      daemonize = false;
    };
  };
}
