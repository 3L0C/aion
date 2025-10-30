{pkgs, ...}: {
  programs.mpv = {
    scripts = [pkgs.custom.mpvScripts.trackselect];
  };
}
