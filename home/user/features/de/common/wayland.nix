{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.envVars =
    {
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
      GDK_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      NIXOS_OZONE_WL = "1";
    }
    // lib.optionalAttrs (config.userSpec.kbdOptions != "") {
      XKB_DEFAULT_OPTIONS = config.userSpec.kbdOptions;
    };

  home.packages = with pkgs; [
    wf-recorder # Utility program for screen recording of wlroots-based compositors
    wl-clipboard # Command-line copy/paste utilities for Wayland
    wlr-randr # Xrandr clone for wlroots compositors
  ];

  xdg = {
    configFile = {
      "electron-flags.conf".text = ''
        --enable-features=UseOzonePlatform
        --ozone-platform=wayland
      '';

      "uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
    };
    portal.config.common.default = "*";
  };
}
