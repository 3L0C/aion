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
  };
  xdg.configFile."xdg-desktop-portal-wlr/config.ini".text = ''
    [screencast]
    chooser_type = simple
    chooser_cmd = ${lib.getExe pkgs.slurp} -f %o -or
  '';
  home.packages = with pkgs; [
    custom.river-shifttags # A small utility for river to help rotate the focused tags
    grim # Screenshot tool
    river-bedload # Display information about river in json in the STDOUT
    slurp # Area selection for screenshots/screensharing
  ];
}
