{ config, ... }:
let
  wkLib = config.flake.lib.wk;
in
{
  flake.modules.homeManager.wk =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      shared = wkLib { inherit pkgs config lib; };

      # Plain wk: settings only, no compositor bindings.
      wk = pkgs.wk.override {
        wksContent = ''
          # Stylix theme colors
          ${shared.themeVars}

          :include "common/settings.wks"
        '';
        wksDirs = [
          (shared.wksDir + "/common")
        ];
      };
    in
    {
      home.packages = [
        wk
        pkgs.wk-prompt
      ];
    };
}
