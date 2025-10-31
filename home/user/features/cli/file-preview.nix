{pkgs, ...}: {
  home.packages = with pkgs; [
    pistol # General purpose file previewer
    mediainfo # Supplies technical and tag information about media files (CLI interface)
    ueberzugpp # Drop in replacement for ueberzug written in C++
  ];
}
