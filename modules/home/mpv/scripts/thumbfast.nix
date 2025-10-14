{ pkgs, ... }:
{
  programs.mpv = {
    scripts = [
      pkgs.mpvScripts.thumbfast
    ];
  };
}
