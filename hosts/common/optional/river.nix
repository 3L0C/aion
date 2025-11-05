{pkgs, ...}: {
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
}
