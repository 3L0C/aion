{
  flake.modules.homeManager.mpv = {pkgs, ...}: {
    home.packages = with pkgs.custom; [
      mpv-scripts # Shell scripts for mpv socket interface (mpv-track et al.)
      mpvUserScripts.smpv
    ];

    programs.mpv.scripts = [pkgs.custom.mpvScripts.mpvSockets-smpv];
  };
}
