{pkgs, ...}: {
  home.packages = with pkgs.custom; [
    mpv-scripts # Shell scripts for mpv socket interface
  ];

  programs.mpv.scripts = [pkgs.custom.mpvScripts.mpvSockets-smpv];
}
