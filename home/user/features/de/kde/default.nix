{pkgs, ...}: {
  stylix.targets.kde.enable = false;
  stylix.targets.qt.enable = false;
  home.packages = with pkgs; [
    kdePackages.dolphin # File manager
    kdePackages.ark # Archive manager
    kdePackages.gwenview # Image viewer
    kdePackages.spectacle # Screenshot tool
    kdePackages.kate # Text editor
    kdePackages.kcalc # Calculator
  ];
}
