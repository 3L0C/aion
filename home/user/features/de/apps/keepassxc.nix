{pkgs, ...}: {
  home.packages = with pkgs; [
    keepassxc # Cross-platform community-driven port of Keepass password manager
  ];
}
