{pkgs, ...}: {
  imports = [
    ./wayland.nix
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  programs.gdk-pixbuf.modulePackages = [pkgs.librsvg];
}
