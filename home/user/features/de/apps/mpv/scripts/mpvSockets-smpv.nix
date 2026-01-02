{pkgs, ...}: {
  home.packages = with pkgs.custom; [
    mpv-scripts # Shell scripts for mpv socket interface
    mpvUserScripts.smpv
  ];

  programs.mpv.scripts = [pkgs.custom.mpvScripts.mpvSockets-smpv];
}
