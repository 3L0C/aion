{pkgs, ...}: {
  imports = [
    ./waybar.nix
    ./style.nix
  ];
  home.packages = with pkgs.custom.scripts.statusbar; [
    sb-playerctl # Media player info
    sb-mpv # MPV player info
    sb-internet # Network status
  ];
}
