{
  flake.modules.homeManager.mpv = {pkgs, ...}: {
    programs.mpv = {
      scripts = [pkgs.custom.mpvScripts.persist-properties];
      scriptOpts = {
        persist_properties = {
          properties = "sub-pos";
        };
      };
    };
  };
}
