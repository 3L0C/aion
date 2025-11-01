{pkgs, ...}: {
  home.packages = with pkgs; [
    mitscheme # MIT/GNU Scheme

    texliveFull # TeX Live environment
    qmk # CLI tool for customizing supported mechanical keyboards

    claude-code # An agentic coding tool that lives in your terminal
    aspell # A spell checker designed to eventually replace Ispell
    aspellDicts.en # English dictionary for aspell
    aspellDicts.en-computers # Aspell dictionary for English Computer Jargon
    highlight # Fast and flexible source code highlighter - CLI version
    ffmpeg # Complete solution to record, convert and stream audio and video
    mkvtoolnix-cli # Set of tools to create, edit and inspect Matroska files
    html-tidy # A tool to tidy down your HTML code to a clear style

    fzf # Command-line fuzzy finder
    ripgrep # A search tool that combines the usability of ag with the raw speed of grep
    fd # Simple, fast and user-friendly alternative to find
    bat # Cat clone with syntax highlighting and git integration
    tmux # Terminal multiplexer

    pistol # General purpose file previewer
    mediainfo # Supplies technical and tag information about media files (CLI interface)
    ueberzugpp # Drop in replacement for ueberzug written in C++
    croc # Easily and securely send things from one computer to another
    catdoc # A convertor for Microsoft Word, Excel, PowerPoint and RTF Files to text

    bc # An arbitrary precision calculator language
    gnuplot # Plotting package which outputs to X11, PostScript, PNG, GIF, and others
  ];
}
