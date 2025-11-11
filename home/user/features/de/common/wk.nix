{pkgs, ...}: {
  home.packages = [pkgs.wk-patched];
  xdg.configFile = {
    "wk/main_key_chords.wks".source = ./wk/wks/main_key_chords.wks;
    "wk/hyprland_key_chords.wks".source = ./wk/wks/hyprland_key_chords.wks;
    "wk/river_key_chords.wks".source = ./wk/wks/river_key_chords.wks;
    "wk/common/applications.wks".source = ./wk/wks/common/applications.wks;
    "wk/common/development.wks".source = ./wk/wks/common/development.wks;
    "wk/common/media.wks".source = ./wk/wks/common/media.wks;
    "wk/common/utilities.wks".source = ./wk/wks/common/utilities.wks;
    "wk/common/system.wks".source = ./wk/wks/common/system.wks;
    "wk/common/screenshots.wks".source = ./wk/wks/common/screenshots.wks;
    "wk/hyprland/window-management.wks".source = ./wk/wks/hyprland/window-management.wks;
    "wk/river/window-management.wks".source = ./wk/wks/river/window-management.wks;
  };
}
