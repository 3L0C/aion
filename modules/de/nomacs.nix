{
  flake.modules.homeManager.nomacs = { pkgs, ... }: {
    home.packages = with pkgs; [
      nomacs # Qt-based image viewer
    ];
  };
}
