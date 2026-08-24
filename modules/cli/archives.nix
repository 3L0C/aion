{
  flake.modules.homeManager.archives = {pkgs, ...}: {
    home.packages = with pkgs; [
      atool # A script for managing file archives of various types
      unzip # For extracting and viewing files in .zip archives
      unrar # The RAR uncompression program
      zip # Compressor/archiver for creating and modifying zipfiles
    ];
  };
}
