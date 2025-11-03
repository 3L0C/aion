{pkgs, ...}: {
  imports = [
    ./settings.nix
  ];
  home.packages = with pkgs.custom.scripts.statusbar; [
    sb-playerctl # Media player info
    sb-mpv # MPV player info
    sb-internet # Network status
  ];
}
