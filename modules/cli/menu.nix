{
  flake.modules.homeManager.menu = { pkgs, ... }: {
    home.packages = with pkgs.custom.scripts.menu; [
      sysact
    ];
  };
}
