{pkgs, ...}: {
  home.packages = with pkgs; [
    catdoc # A convertor for Microsoft Word, Excel, PowerPoint and RTF Files to text
    groff # GNU troff text-formatting system
    gnuplot # Plotting package which outputs to X11, PostScript, PNG, GIF, and others
    glow # Command-line markdown renderer
    htop-vim # Interactive process viewer with a Vim keybindings patch
    jqp # TUI playground to experiment with jq
    dialog # Display dialog boxes from shell scripts
    lynx # Text browser for the World Wide Web
    mtools # Collection of utilities to access MS-DOS disks
    sfeed # RSS and Atom parser
    xidel # Command line tool to process HTML/XML/JSON
    perl5Packages.FileMimeInfo # Determine file type (mimeopen, mimetype)
    perl5Packages.TermReadKey # Simple control over terminal driver modes
  ];
}
