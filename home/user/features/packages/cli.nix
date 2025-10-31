{pkgs, ...}: {
  home.packages = with pkgs; [
    git-crypt # Transparent file encryption in git
  ];
}
