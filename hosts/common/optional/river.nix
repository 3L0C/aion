{pkgs, ...}: {
  programs = {
    river-classic.enable = true;

    gdk-pixbuf.modulePackages = [pkgs.librsvg];

    uwsm = {
      enable = true;
      waylandCompositors = {
        river = {
          prettyName = "River";
          comment = "River compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/river";
        };
      };
    };
  };
  environment.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    MOZ_ENABLE_WAYLAND = 1;
    MOZ_WEBRENDER = 1;
    NIXOS_OZONE_WL = 1;
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}
