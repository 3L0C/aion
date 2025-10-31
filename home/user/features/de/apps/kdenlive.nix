{pkgs, ...}: {
  home.packages = with pkgs; [
    kdePackages.kdenlive # A non-linear video editor for Linux using the MLT video framework
  ];
}
