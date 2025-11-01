{pkgs, ...}: {
  home.packages = with pkgs; [
    bat # Cat clone with syntax highlighting and git integration
    fzf # Command-line fuzzy finder
    ripgrep # Fast search tool combining usability of ag with speed of grep
    tmux # Terminal multiplexer
    chafa # Image-to-text converter for terminal display
  ];
}
