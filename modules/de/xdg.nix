{
  flake.modules.homeManager.xdg = {
    config,
    lib,
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
        defaultApplications = lib.genAttrs [
          "text/html"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
          "x-scheme-handler/about"
          "x-scheme-handler/unknown"
        ] (_: config.userSpec.defaultBrowser);
      };

      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = [pkgs.xdg-desktop-portal-wlr];
      };

      # User directory paths - using standard capitalized names
      userDirs = {
        enable = true;
        createDirectories = true;
        desktop = "${home}/Desktop";
        documents = "${home}/Documents";
        download = "${home}/Downloads";
        music = "${home}/Music";
        pictures = "${home}/Pictures";
        projects = "${home}/Projects";
        publicShare = "${home}/Public";
        templates = "${home}/Templates";
        videos = "${home}/Videos";
      };
    };
  };
}
