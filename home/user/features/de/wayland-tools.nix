{pkgs, ...}: {
  home.packages = with pkgs; [
    wl-clipboard # Command-line copy/paste utilities for Wayland
    grim # Screenshot utility for Wayland
    wlr-randr # Utility to manage outputs of a Wayland compositor
  ];
}
