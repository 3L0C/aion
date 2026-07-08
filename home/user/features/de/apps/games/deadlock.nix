{pkgs, ...}: {
  home.packages = with pkgs; [
    deadlock-mod-manager
  ];
}
