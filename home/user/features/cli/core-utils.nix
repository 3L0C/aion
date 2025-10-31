{pkgs, ...}: {
  home.packages = with pkgs; [
    file # Program that shows the type of files
    wget # Network utility to retrieve files from the web
    curl # command line tool and library for transferring data with URLs
    rsync # A fast and versatile file copying tool for remote and local files
    tree # A directory listing program displaying a depth indented list of files
    findutils # GNU utilities to locate files
    gnugrep # A string search utility
    gnused # GNU stream editor
    gawk # GNU version of awk
    gettext # GNU internationalization library
    inetutils # A collection of common network programs
  ];
}
