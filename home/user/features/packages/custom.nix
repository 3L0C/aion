{pkgs, ...}: {
  home.packages = with pkgs.custom; [
    mpv-scripts # Shell scripts for mpv socket interface
  ];
}
