{pkgs, ...}: {
  home.packages = with pkgs; [
    xdg-desktop-portal # Desktop integration portals for sandboxed apps
    xdg-desktop-portal-gtk # GTK backend for xdg-desktop-portal
    xdg-desktop-portal-wlr # wlroots backend for xdg-desktop-portal
    kdePackages.xdg-desktop-portal-kde # KDE backend for xdg-desktop-portal
    xdg-user-dirs # Manage user directories like ~/Desktop and ~/Music
    xdg-utils # Desktop integration tasks (xdg-open, etc.)
  ];
}
