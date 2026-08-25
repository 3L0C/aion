{
  flake.modules.homeManager.cli-core = { pkgs, ... }: {
    home.packages = with pkgs; [
      bc # An arbitrary precision calculator language
      stable.croc # Easily and securely send things from one computer to another (unstable v10.4.5 tag re-pushed upstream → hash mismatch; revert once nixpkgs fixes it)
      curl # command line tool and library for transferring data with URLs
      desktop-file-utils # Utilities for working with .desktop files
      fd # Simple, fast and user-friendly alternative to find
      fdupes # Identify or delete duplicate files
      file # Program that shows the type of files
      findutils # GNU utilities to locate files
      gawk # GNU version of awk
      gettext # GNU internationalization library
      gnugrep # A string search utility
      gnupatch # GNU patch utility to apply patch files
      gnused # GNU stream editor
      gzip # GNU compression utility
      htop-vim # Interactive process viewer with a Vim keybindings patch
      inetutils # A collection of common network programs
      jq # Command-line JSON processor
      moreutils # Collection of unix tools (sponge, parallel, etc.)
      mtools # Collection of utilities to access MS-DOS disks
      perl5Packages.FileMimeInfo # Determine file type (mimeopen, mimetype)
      perl5Packages.TermReadKey # Simple control over terminal driver modes
      ripgrep # Fast search tool combining usability of ag with speed of grep
      rmlint # Remove duplicates and other lint
      rsync # A fast and versatile file copying tool for remote and local files
      texinfo # GNU documentation system for on-line information and printed output
      trash-cli # Command line trashcan (recycle bin) interface
      tree # A directory listing program displaying a depth indented list of files
      wget # Network utility to retrieve files from the web
    ];
  };
}
