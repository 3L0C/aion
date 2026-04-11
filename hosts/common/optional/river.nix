{
  lib,
  pkgs,
  ...
}: let
  portalChooser = pkgs.writeShellApplication {
    name = "xdph-wlr-chooser";
    runtimeInputs = with pkgs; [rofi];
    text = ''
      exec rofi -dmenu -i -p "Screencast source"
    '';
  };
in {
  imports = [
    ./wayland.nix
  ];

  programs = {
    river-uwsm = {
      enable = true;
      extraPackages = [];
    };
    gdk-pixbuf.modulePackages = [pkgs.librsvg];
  };
  xdg.portal.wlr.settings.screencast = {
    chooser_type = "dmenu";
    chooser_cmd = lib.getExe portalChooser;
  };
}
