{pkgs, ...}: {
  home.packages = with pkgs; [
    catdoc # A convertor for Microsoft Word, Excel, PowerPoint and RTF Files to text
    groff # GNU troff text-formatting system
    texinfo # GNU documentation system for on-line information and printed output
    bc # An arbitrary precision calculator language
    gnuplot # Plotting package which outputs to X11, PostScript, PNG, GIF, and others
    glow # Command-line markdown renderer
    htop-vim # Interactive process viewer with a Vim keybindings patch
    gnupatch # GNU patch utility to apply patch files
    fdupes # Identify or delete duplicate files
    rmlint # Remove duplicates and other lint
    moreutils # Collection of unix tools (sponge, parallel, etc.)
    trash-cli # Command line trashcan (recycle bin) interface

    # Help & documentation
    man-pages # Linux man pages
    tldr # Simplified and community-driven man pages
    jq # Command-line JSON processor
    jqp # TUI playground to experiment with jq
    dialog # Display dialog boxes from shell scripts
    abook # Text-based addressbook
    dict # Dictionary client
    git-crypt # Transparent file encryption in git
    lynx # Text browser for the World Wide Web
    mermaid-cli # Generate diagrams from markdown-like text
    mtools # Collection of utilities to access MS-DOS disks
    sfeed # RSS and Atom parser
    xidel # Command line tool to process HTML/XML/JSON
    perl540Packages.FileMimeInfo # Determine file type (mimeopen, mimetype)
    perl540Packages.TermReadKey # Simple control over terminal driver modes
  ];
}
