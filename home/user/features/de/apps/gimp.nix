{pkgs, ...}: {
  home.packages = with pkgs; [
    gimp3 # GNU Image Manipulation Program
    inkscape # Vector graphics editor
  ];
}
