{pkgs, ...}: {
  imports = [
    ./wayland.nix
  ];

  programs = {
    river-uwsm-dev = {
      enable = true;
      extraPackages = [];
    };
    gdk-pixbuf.modulePackages = [pkgs.librsvg];
  };
}
