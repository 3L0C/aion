{pkgs, ...}: {
  imports = [
    ./waybar.nix
  ];
  home.packages = with pkgs.custom.scripts; [
    hypr-layout # Hyprland layout display
  ];
}
