{
  flake.modules.homeManager.man = {pkgs, ...}: {
    programs.man = {
      enable = true;
      generateCaches = true;
    };

    # Linux development manual pages
    home.packages = [pkgs.man-pages];
  };
}
