{
  flake.modules.homeManager.web-tools = {pkgs, ...}: {
    home.packages = with pkgs; [
      jqp # TUI playground to experiment with jq
      lynx # Text browser for the World Wide Web
      sfeed # RSS and Atom parser
      xidel # Command line tool to process HTML/XML/JSON
    ];
  };
}
