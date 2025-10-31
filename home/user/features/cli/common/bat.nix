{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "gruvbox-dark";
    };
    extraPackages = builtins.attrValues {
      inherit (pkgs.stable.bat-extras) batdiff batman batgrep batpipe;
    };
  };
}
