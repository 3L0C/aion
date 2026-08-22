# Help & documentation
{pkgs, ...}: {
  home.packages = with pkgs; [
    man-pages # Linux development manual pages
    tldr # Simplified and community-driven man pages
  ];
}
