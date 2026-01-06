{pkgs, ...}: {
  imports = [
    ./wayland.nix
  ];

  programs = {
    river-uwsm-test = {
      enable = true;
      extraPackages = [];
    };
    gdk-pixbuf.modulePackages = [pkgs.librsvg];
  };
}
