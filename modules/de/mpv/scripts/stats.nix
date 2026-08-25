{
  flake.modules.homeManager.mpv = { pkgs, ... }: {
    programs.mpv = {
      scripts = [ pkgs.custom.mpvScripts.stats ];
      bindings = {
        "e" = "script-binding stats/display-stats";
        "E" = "script-binding stats/display-stats-toggle";
      };
    };
  };
}
