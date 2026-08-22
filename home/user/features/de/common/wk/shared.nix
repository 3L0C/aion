# Shared wk helpers. mkWkVariant builds compositor-specific wk binaries.
{
  pkgs,
  config,
  lib,
}: let
  wksDir = ./wks;

  base16Colors = [
    "base00"
    "base01"
    "base02"
    "base03"
    "base04"
    "base05"
    "base06"
    "base07"
    "base08"
    "base09"
    "base0A"
    "base0B"
    "base0C"
    "base0D"
    "base0E"
    "base0F"
  ];

  themeVars = lib.concatStringsSep "\n" (
    map (name: '':var "${name}" "${config.lib.stylix.colors.withHashtag.${name}}"'') base16Colors
  );
in {
  inherit wksDir themeVars;
  mkWkVariant = {
    name,
    entryPoint,
  }:
    (pkgs.wk.override {
      wksContent = ''
        # Stylix theme colors
        ${themeVars}

        :include "${entryPoint}"
      '';
      wksDirs = [
        (wksDir + "/common")
        (wksDir + "/${name}")
      ];
    }).overrideAttrs
    (old: {
      pname = "wk-${name}";
      postInstall =
        (old.postInstall or "")
        + ''
          mv $out/bin/wk $out/bin/wk-${name}
          rm -rf $out/share/man
        '';
    });

  # Plain wk: settings only, no compositor bindings.
  wk = pkgs.wk.override {
    wksContent = ''
      # Stylix theme colors
      ${themeVars}

      :include "common/settings.wks"
    '';
    wksDirs = [
      (wksDir + "/common")
    ];
  };
}
