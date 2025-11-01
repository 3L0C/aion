{pkgs, ...}: {
  home.packages = with pkgs; [
    epub-thumbnailer # EPUB e-books thumbnailer
    ffmpegthumbnailer # Lightweight video thumbnailer
  ];
}
