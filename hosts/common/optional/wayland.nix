{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    config.common.default = "*";
  };
  programs.gdk-pixbuf.modulePackages = [pkgs.librsvg];
}
