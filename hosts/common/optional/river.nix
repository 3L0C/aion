{
  lib,
  pkgs,
  ...
}: {
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
  xdg.portal.wlr.enable = lib.mkForce false;
}
