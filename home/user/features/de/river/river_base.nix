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
      ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: value: "export ${name}=${value}") config.wayland.envVars)}

      # Notify UWSM that River is ready
      uwsm finalize
    '';
  };
  xdg.configFile."xdg-desktop-portal-wlr/config.ini".text = ''
    [screencast]
    chooser_type = simple
    chooser_cmd = ${lib.getExe pkgs.slurp} -f %o -or
  '';
  xdg.configFile."xdg-desktop-portal/river-portals.conf".text = ''
    [preferred]
    default=gtk
    org.freedesktop.impl.portal.ScreenCast=wlr
    org.freedesktop.impl.portal.Screenshot=wlr
    org.freedesktop.impl.portal.Inhibit=none
  '';
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
