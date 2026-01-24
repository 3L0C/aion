{pkgs, ...}: {
  home.packages = with pkgs; [
    firefox
    stable.librewolf
    brave
    chromium
  ];
}
