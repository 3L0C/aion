{pkgs, ...}: {
  home.packages = with pkgs; [
    vlc # Versatile media player with extensive codec support
  ];
}
