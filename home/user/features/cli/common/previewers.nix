{pkgs, ...}: {
  home.packages = with pkgs; [
    chafa # Image-to-text converter for terminal display
    epub-thumbnailer # EPUB e-books thumbnailer
    ffmpegthumbnailer # Lightweight video thumbnailer
    stable.highlight # Fast and flexible source code highlighter - CLI version
    pistol # General purpose file previewer
    mediainfo # Supplies technical and tag information about media files (CLI interface)
    ueberzugpp # Drop in replacement for ueberzug written in C++
  ];
}
