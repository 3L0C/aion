{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    wf-recorder # Utility program for screen recording of wlroots-based compositors
    wl-clipboard # Command-line copy/paste utilities for Wayland
    wlr-randr # Xrandr clone for wlroots compositors
  ];

  home.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    LIBSEAT_BACKEND = "logind";
    MOZ_ENABLE_WAYLAND = 1;
    MOZ_WEBRENDER = 1;
    NIXOS_OZONE_WL = 1;
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  xdg.configFile = {
    "electron-flags.conf".text = ''
      --enable-features=UseOzonePlatform
      --ozone-platform=wayland
    '';

    "uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  };
}
