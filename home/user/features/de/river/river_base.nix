{
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.river = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = false; # UWSM handles systemd integration
    };
  };
  xdg.portal = {
    extraPortals = [pkgs.xdg-desktop-portal-wlr];
    configPackages = [pkgs.river-classic];
  };
  xdg.configFile."xdg-desktop-portal-wlr/config.ini".text = ''
    [screencast]
    chooser_type = simple
    chooser_cmd = ${lib.getExe pkgs.slurp} -f %o -or
  '';
  home.packages = with pkgs; [
    slurp # Area selection for screenshots/screensharing
    grim # Screenshot tool
  ];
}
