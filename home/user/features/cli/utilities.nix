{pkgs, ...}: {
  home.packages = with pkgs; [
    catdoc # A convertor for Microsoft Word, Excel, PowerPoint and RTF Files to text
    bc # An arbitrary precision calculator language
    gnuplot # Plotting package which outputs to X11, PostScript, PNG, GIF, and others
    glow # Command-line markdown renderer
    htop-vim # Interactive process viewer with a Vim keybindings patch
  ];
}
