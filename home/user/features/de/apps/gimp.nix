{pkgs, ...}: {
  home.packages = with pkgs; [
    gimp3 # GNU Image Manipulation Program
    inkscape # Vector graphics editor
    custom.openshot-qt # Free, open-source video editor
    nomacs # Qt-based image viewer
  ];
}
