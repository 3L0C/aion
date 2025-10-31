{pkgs, ...}: {
  programs.mpv = {
    scripts = [
      pkgs.mpvScripts.builtins.autocrop
    ];
    scriptOpts = {
      autocrop = {
        auto = false;
      };
    };
  };
}
