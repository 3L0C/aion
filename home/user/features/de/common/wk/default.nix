{
  pkgs,
  config,
  lib,
  ...
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
    map (name: '':var "${name}" "${config.lib.stylix.colors.withHashtag.${name}}"'')
    base16Colors
  );
  wk-hyprland =
    (pkgs.wk.override {
      wksContent = ''
        ${themeVars}
        :include "hyprland/hyprland_key_chords.wks"
      '';
      wksDirs = [
        (wksDir + "/common") # Common DE-agnostic configs
        (wksDir + "/hyprland") # Hyprland-specific configs
      ];
    }).overrideAttrs (old: {
      pname = "wk-hyprland";
      postInstall =
        (old.postInstall or "")
        + ''
          mv $out/bin/wk $out/bin/wk-hyprland
          rm -rf $out/share/man
        '';
    });
  wk-river =
    (pkgs.wk.override {
      wksContent = ''
        ${themeVars}
        :include "river/river_key_chords.wks"
      '';
      wksDirs = [
        (wksDir + "/common") # Common DE-agnostic configs
        (wksDir + "/river") # River-specific configs
      ];
    }).overrideAttrs (old: {
      pname = "wk-river";
      postInstall =
        (old.postInstall or "")
        + ''
          mv $out/bin/wk $out/bin/wk-river
          rm -rf $out/share/man
        '';
    });
  wk = pkgs.wk.override {
    wksContent = ''
      ${themeVars}
      :include "common/settings.wks"
    '';
    wksDirs = [
      (wksDir + "/common") # Common directory for settings.wks
    ];
  };
in {
  home.packages = [
    wk
    wk-hyprland
    wk-river
  ];
}
