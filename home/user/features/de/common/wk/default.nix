{pkgs, ...}: {
  home.packages = [pkgs.wk-patched];
  xdg.configFile = {
    "wk/main_key_chords.wks".source = ./wks/main_key_chords.wks;
    "wk/hyprland_key_chords.wks".source = ./wks/hyprland_key_chords.wks;
    "wk/river_key_chords.wks".source = ./wks/river_key_chords.wks;
    "wk/common/applications.wks".source = ./wks/common/applications.wks;
    "wk/common/development.wks".source = ./wks/common/development.wks;
    "wk/common/media.wks".source = ./wks/common/media.wks;
    "wk/common/utilities.wks".source = ./wks/common/utilities.wks;
    "wk/common/system.wks".source = ./wks/common/system.wks;
    "wk/common/screenshots.wks".source = ./wks/common/screenshots.wks;
    "wk/common/window-management.wks".source = ./wks/common/window-management.wks;
    "wk/hyprland/window-management.wks".source = ./wks/hyprland/window-management.wks;
    "wk/river/window-management.wks".source = ./wks/river/window-management.wks;
  };
}
