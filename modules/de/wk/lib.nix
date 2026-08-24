# Shared wk helpers. mkWkVariant builds compositor-specific wk binaries.
{
  flake.lib.wk = {
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

    # Build a compositor-specific wk binary. `dir` is the caller's wks
    # directory; it can live next to the calling aspect. wk copies each
    # wksDirs entry into config/ under its basename, so the entry
    # include resolves as "<basename of dir>/<entryFile>". Includes
    # inside the wks files are relative to the including file;
    # "../common/..." reaches the shared chords.
    # Usage: mkWkVariant { name = "oxbow"; dir = ./wks; }
    mkWkVariant = {
      name,
      dir,
      entryFile ? "key_chords.wks",
    }:
      (pkgs.wk.override {
        wksContent = ''
          # Stylix theme colors
          ${themeVars}

          :include "${baseNameOf dir}/${entryFile}"
        '';
        wksDirs = [
          (wksDir + "/common")
          dir
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
  };
}
