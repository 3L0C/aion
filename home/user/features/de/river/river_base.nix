{
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
      # Notify UWSM that River is ready
      uwsm finalize
    '';
  };
  xdg.configFile."xdg-desktop-portal-wlr/config.ini".text = ''
    [screencast]
    chooser_type = simple
    chooser_cmd = ${lib.getExe pkgs.slurp} -f %o -or
  '';
  home.packages = with pkgs; [
    custom.river-shifttags # Utility to rotate focused tags or send views to rotated tags (patched with --send-view)
    grim # Screenshot tool
    lswt # Command that lists Wayland toplevels
    river-bedload # Display information about river in json in the STDOUT
    slurp # Area selection for screenshots/screensharing
    wayshot # Native, blazing-fast screenshot tool for wlroots based compositors such as sway and river
    wev # Wayland event viewer
  ];
}
