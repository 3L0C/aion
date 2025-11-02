{pkgs, ...}: {
  home.packages = with pkgs.custom.scripts; [
    nb
  ];
}
