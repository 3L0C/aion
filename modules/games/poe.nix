{
  flake.modules.homeManager.games = { pkgs, ... }: {
    home.packages = with pkgs; [
      awakened-poe-trade # Path of Exile trading app for price checking
      rusty-path-of-building # A cross-platform runtime for Path of Building and Path of Building 2.
    ];
  };
}
