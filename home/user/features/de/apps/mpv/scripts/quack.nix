{pkgs, ...}: {
  programs.mpv = {
    scripts = [pkgs.mpvScripts.quack];
  };
}
