{
  lib,
  pkgs,
  ...
}: {
  userSpec = {
    kbdOptions = lib.mkDefault "";
    theme = {
      base16Scheme = lib.mkDefault "kanagawa-abyss";
      polarity = lib.mkDefault "dark";
      wallpaper = lib.mkDefault ../features/de/wallpapers/1450741833367.jpg;
    };
    cursor = {
      package = lib.mkDefault pkgs.phinger-cursors;
      name = lib.mkDefault "phinger-cursors-dark";
      baseSize = lib.mkDefault 24;
    };
    fonts = {
      emoji = {
        package = lib.mkDefault pkgs.noto-fonts-color-emoji;
        name = lib.mkDefault "Noto Color Emoji";
      };
      monospace = {
        package = lib.mkDefault pkgs.nerd-fonts.jetbrains-mono;
        name = lib.mkDefault "JetBrainsMonoNL Nerd Font";
      };
      sansSerif = {
        package = lib.mkDefault pkgs.inter-nerdfont;
        name = lib.mkDefault "Inter Nerd Font";
      };
      serif = {
        package = lib.mkDefault pkgs.inter-nerdfont;
        name = lib.mkDefault "Inter Nerd Font";
      };
      sizes = {
        applications = lib.mkDefault 14;
        desktop = lib.mkDefault 14;
        popups = lib.mkDefault 14;
        terminal = lib.mkDefault 16;
      };
    };
    icons = {
      package = lib.mkDefault pkgs.papirus-icon-theme;
      dark = lib.mkDefault "Papirus-Dark";
      light = lib.mkDefault "Papirus-Light";
    };
    opacity = {
      applications = lib.mkDefault 1.0;
      desktop = lib.mkDefault 1.0;
      popups = lib.mkDefault 1.0;
      terminal = lib.mkDefault 1.0;
    };
  };
}
