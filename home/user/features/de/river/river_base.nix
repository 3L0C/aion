{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.river = {
    enable = true;
    package = null;
    systemd = {
      enable = false; # UWSM handles systemd integration
    };
    xwayland.enable = true;
    extraConfig = ''
      ${lib.concatStringsSep "\n" (
        lib.mapAttrsToList (name: value: "export ${name}=${value}") config.wayland.envVars
      )}

      # Notify UWSM that River is ready
      uwsm finalize
    '';
  };

  xdg.configFile = let
    portalText = ''
      [preferred]
      default=gtk
      org.freedesktop.impl.portal.ScreenCast=wlr
      org.freedesktop.impl.portal.Screenshot=wlr
      org.freedesktop.impl.portal.Inhibit=none
    '';
  in {
    "xdg-desktop-portal/river-portals.conf".text = portalText;
    "xdg-desktop-portal/riverdev-portals.conf".text = portalText;
  };
  home.packages = with pkgs; [
    riverdo # Improved riverctl
    grim # Screenshot tool
    lswt # Command that lists Wayland toplevels
    ristate # River-status client written in Rust
    river-bedload # Display information about river in json in the STDOUT
    slurp # Area selection for screenshots/screensharing
    wayshot # Native, blazing-fast screenshot tool for wlroots based compositors such as sway and river
    wev # Wayland event viewer
    wlopm # Simple client implementing zwlr-output-power-management-v1
  ];
}
