{pkgs, ...}: {
  userSpec = {
    kbdOptions = "";
    theme = {
      base16Scheme = "kanagawa-abyss";
      polarity = "dark";
      wallpaper = ../features/de/wallpapers/1450741833367.jpg;
    };
    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
      baseSize = 24;
    };
    fonts = {
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMonoNL Nerd Font";
      };
      sansSerif = {
        package = pkgs.inter-nerdfont;
        name = "Inter Nerd Font";
      };
      serif = {
        package = pkgs.inter-nerdfont;
        name = "Inter Nerd Font";
      };
      sizes = {
        applications = 14;
        desktop = 14;
        popups = 14;
        terminal = 16;
      };
    };
    icons = {
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
    opacity = {
      applications = 1.0;
      desktop = 1.0;
      popups = 1.0;
      terminal = 1.0;
    };
  };
}
