{
  flake.modules.homeManager.dev = {pkgs, ...}: {
    home.packages = with pkgs; [
      texliveFull # TeX Live environment
    ];
  };
}
