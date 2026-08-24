{
  flake.modules.homeManager.mpv = {pkgs, ...}: {
    programs.mpv.scripts = [pkgs.custom.mpvScripts.trackselect];
  };
}
