{pkgs, ...}: {
  imports = [
    ./style.nix
  ];

  # Statusbar scripts used by waybar modules
  home.packages = with pkgs.custom.scripts.statusbar; [
    sb-playerctl # Media player info
    sb-mpv # MPV player info
    sb-internet # Network status
  ];
}
