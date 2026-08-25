# Help & documentation
{
  flake.modules.homeManager.help = { pkgs, ... }: {
    home.packages = with pkgs; [
      tldr # Simplified and community-driven man pages
    ];
  };
}
