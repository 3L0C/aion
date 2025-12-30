{pkgs, ...}: {
  xdg.portal.config.common.default = "*";
  programs.gdk-pixbuf.modulePackages = [pkgs.librsvg];
}
