{
  flake.modules.homeManager.mpv = {pkgs, ...}: {
    programs.mpv = {
      # This script uses the lavfi cropdetect filter to automatically insert a
      # crop filter with appropriate parameters for the currently playing video
      scripts = [pkgs.mpvScripts.builtins.autocrop];
      scriptOpts = {
        autocrop = {
          auto = false;
        };
      };
    };
  };
}
