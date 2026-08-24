{
  flake.modules.homeManager.mpv = {pkgs, ...}: {
    programs.mpv.scripts = [pkgs.mpvScripts.mpv-webm];
  };
}
