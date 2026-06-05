{pkgs, ...}: {
  home.packages = with pkgs.master; [
    deadlock-mod-manager
  ];
}
