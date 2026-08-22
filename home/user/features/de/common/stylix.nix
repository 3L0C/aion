{
  config,
  inputs,
  pkgs,
  ...
}: let
  monitorScale = let
    scaleStr = config.primaryMonitor.scale or "1";
  in
    if scaleStr == "auto"
    then 1.0
    else builtins.fromJSON scaleStr;

  scaledCursorSize = builtins.floor (config.userSpec.cursor.baseSize * monitorScale);

  us = config.userSpec;
in {
  imports = [inputs.stylix.homeModules.stylix];

  # Stylix's cursor.nix sets name/package/size but not enable, so without this
  # the cursor silently reverts to the wlroots default.
  home.pointerCursor.enable = true;

  stylix = {
    enable = true;
    overlays.enable = false;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/${us.theme.base16Scheme}.yaml";
    inherit (us.theme) polarity;
    image = us.theme.wallpaper;

    cursor = {
      inherit (us.cursor) package name;
      size = scaledCursorSize;
    };

    fonts = {
      emoji = {
        inherit (us.fonts.emoji) package name;
      };
      monospace = {
        inherit (us.fonts.monospace) package name;
      };
      sansSerif = {
        inherit (us.fonts.sansSerif) package name;
      };
      serif = {
        inherit (us.fonts.serif) package name;
      };
      sizes = {
        inherit (us.fonts.sizes) applications desktop popups terminal;
      };
    };

    icons = {
      enable = true;
      inherit (us.icons) package dark light;
    };

    opacity = {
      inherit (us.opacity) applications desktop popups terminal;
    };
  };
}
