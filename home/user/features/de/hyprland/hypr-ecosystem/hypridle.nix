{
  config,
  pkgs,
  ...
}: let
  hyprctl = "${config.wayland.windowManager.hyprland.finalPackage}/bin/hyprctl";
  hyprlock = "${config.programs.hyprlock.package}/bin/hyprlock";
  loginctl = "${pkgs.systemd}/bin/loginctl";

  baseTimeout = 900;
in {
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || ${hyprlock} --immediate --no-fade-in";
        before_sleep_cmd = "${loginctl} lock-session";
        after_sleep_cmd = "${hyprctl} dispatch dpms on";
        inhibit_sleep = 3; # Wait until session gets locked before going to sleep
      };

      listener = [
        {
          timeout = baseTimeout;
          on-timeout = "${loginctl} lock-session";
        }
        {
          timeout = baseTimeout + 60;
          on-timeout = "${hyprctl} dispatch dpms off";
          on-resume = "${hyprctl} dispatch dpms on";
        }
      ];
    };
  };
}
