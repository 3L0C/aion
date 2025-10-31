{pkgs, ...}: {
  home.packages = with pkgs; [
    gzip # GNU compression utility
    zip # Compressor/archiver for creating and modifying zipfiles
    unzip # For extracting and viewing files in .zip archives
    unrar # The RAR uncompression program
    atool # A script for managing file archives of various types
  ];
}
