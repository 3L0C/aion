{
  config,
  pkgs,
  ...
}: let
  home = config.home.homeDirectory;
  shadowedXdgOpen = pkgs.writeShellScriptBin "xdg-open" ''
    handlr open "$@"
  '';
in {
  home.packages = [
    pkgs.handlr-regex
    shadowedXdgOpen
  ];

  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
    };

    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [pkgs.xdg-desktop-portal-wlr];
    };

    # User directory paths - using standard capitalized names
    userDirs = {
      enable = true;
      createDirectories = true; # Automatically create directories

      desktop = "${home}/Desktop";
      documents = "${home}/Documents";
      download = "${home}/Downloads";
      music = "${home}/Music";
      pictures = "${home}/Pictures";
      publicShare = "${home}/Public";
      templates = "${home}/Templates";
      videos = "${home}/Videos";
    };
  };
}
