{
  flake.modules.homeManager.vesktop = { pkgs, ... }: {
    home.packages = with pkgs; [
      vesktop # Alternate client for Discord with Vencord built-in
    ];
  };
}
