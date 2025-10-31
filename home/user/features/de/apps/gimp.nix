{pkgs, ...}: {
  home.packages = with pkgs; [
    gimp3 # GNU Image Manipulation Program
  ];
}
