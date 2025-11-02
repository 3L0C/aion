# Help & documentation
{pkgs, ...}: {
  home.packages = with pkgs; [
    man-pages # Linux man pages
    tldr # Simplified and community-driven man pages
  ];
}
