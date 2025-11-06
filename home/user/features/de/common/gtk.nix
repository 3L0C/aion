{pkgs, ...}: {
  gtk = let
    commonExtraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-decoration-layout = "appmenu";
      gtk-dialogs-use-header = false;
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
      gtk-error-bell = 0;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
    hideDecorationsCSS = ''
      /* Hide GTK client-side decorations (CSD) */
      headerbar.default-decoration {
        margin-bottom: 50px;
        margin-top: -100px;
      }

      /* Remove window shadows from CSD windows */
      window.csd,
      window.csd decoration {
        box-shadow: none;
      }
    '';
  in {
    enable = true;

    gtk3.extraConfig = commonExtraConfig;
    gtk4.extraConfig = commonExtraConfig;
    gtk3.extraCss = hideDecorationsCSS;
    gtk4.extraCss = hideDecorationsCSS;
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
}
