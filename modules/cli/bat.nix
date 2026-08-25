{
  flake.modules.homeManager.bat = { pkgs, ... }: {
    programs.bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
      extraPackages = builtins.attrValues {
        inherit (pkgs.stable.bat-extras)
          batdiff
          batman
          batgrep
          batpipe
          ;
      };
    };
  };
}
