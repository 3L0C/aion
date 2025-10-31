{pkgs, ...}: {
  home.packages = with pkgs; [
    croc # Easily and securely send things from one computer to another
    gallery-dl # Command-line program to download image-galleries and collections from several image hosting sites
    yt-dlp # A youtube-dl fork with additional features and fixes
  ];
}
