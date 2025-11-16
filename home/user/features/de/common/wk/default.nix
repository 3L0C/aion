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
  themeWks = pkgs.writeText "theme.wks" (
    lib.concatStringsSep "\n" (
      map (name: '':var "${name}" "${config.lib.stylix.colors.withHashtag.${name}}"'')
      base16Colors
    )
  );
  themeDir = pkgs.runCommand "wk-theme" {} ''
    mkdir -p $out
    cp ${themeWks} $out/theme.wks
  '';
  wk-hyprland =
    (pkgs.wk.override {
      wksFile = wksDir + "/hyprland/hyprland_key_chords.wks";
      wksDirs = [
        themeDir # Contains theme.wks, copied as config/wk-theme/
        (wksDir + "/common") # Common DE-agnostic configs, copied as config/common/
        (wksDir + "/hyprland") # Hyprland-specific configs, copied as config/hyprland/
      ];
    }).overrideAttrs {
      pname = "wk-hyprland";
    };
  wk-river =
    (pkgs.wk.override {
      wksFile = wksDir + "/river/river_key_chords.wks";
      wksDirs = [
        themeDir # Contains theme.wks, copied as config/wk-theme/
        (wksDir + "/common") # Common DE-agnostic configs, copied as config/common/
        (wksDir + "/river") # River-specific configs, copied as config/river/
      ];
    }).overrideAttrs {
      pname = "wk-river";
    };
in {
  home.packages = [
    wk-hyprland
    wk-river
  ];
}
