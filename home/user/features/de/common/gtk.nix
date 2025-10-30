{ pkgs, ... }:
{
  gtk = {
    enable = true;
    font = {
      name = "sans";
      size = 12;
    };
    theme = {
      name = "Kanagawa-Dark";
      package = pkgs.kanagawa-gtk-theme; 
    };
    iconTheme = {
      name = "Kanagawa-Dark";
      package = pkgs.kanagawa-icon-theme; # { color = "dark"; };
    };
    cursorTheme = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 24;
    };
  };

  home.pointerCursor = {
    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
    size = 24;
    gtk.enable = true;
  };
}
