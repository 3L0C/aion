{
  flake.modules.homeManager.gimp = { pkgs, ... }: {
    home.packages = with pkgs; [
      gimp3 # GNU Image Manipulation Program
    ];
  };
}
