{pkgs, ...}: {
  home.packages = with pkgs; [
    lxappearance # Feature-rich GTK+ theme switcher of the LXDE Desktop
    libsForQt5.qt5ct # Qt5 Configuration Utility
    kdePackages.qt6ct # Qt 6 Configuration Utility
    nwg-look # GTK settings editor adapted to work on wlroots-based compositors
    font-manager # A simple font management application for GTK+ Desktop Environments
  ];
}
