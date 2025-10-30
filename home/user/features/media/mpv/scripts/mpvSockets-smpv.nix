{pkgs, ...}: {
  programs.mpv.scripts = [pkgs.custom.mpvScripts.mpvSockets-smpv];
}
