{pkgs, ...}: {
  programs.mpv = {
    scripts = [
      pkgs.mpvScripts.mpv-webm
    ];
  };
}
