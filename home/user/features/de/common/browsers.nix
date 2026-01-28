{pkgs, ...}: {
  home.packages = with pkgs; [
    firefox
    librewolf
    brave
    chromium
  ];
}
