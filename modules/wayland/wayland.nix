# Wayland base configuration.
{
  flake.modules.nixos.wayland = { pkgs, ... }: {
    xdg.portal = {
      enable = true;
      config.common.default = "*";
    };
    programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
  };
}
