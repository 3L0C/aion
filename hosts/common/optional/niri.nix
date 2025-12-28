{pkgs, ...}: {
  imports = [
    ./wayland.nix
  ];

  programs = {
    niri.enable = true;
    gdk-pixbuf.modulePackages = [pkgs.librsvg];
  };
}
