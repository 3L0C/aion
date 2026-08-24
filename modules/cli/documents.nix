{
  flake.modules.homeManager.documents = {pkgs, ...}: {
    home.packages = with pkgs; [
      catdoc # A convertor for Microsoft Word, Excel, PowerPoint and RTF Files to text
      glow # Command-line markdown renderer
      gnuplot # Plotting package which outputs to X11, PostScript, PNG, GIF, and others
      groff # GNU troff text-formatting system
    ];
  };
}
