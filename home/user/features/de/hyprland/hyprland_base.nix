{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    xwayland.enable = true;
  };
  services.hyprpolkitagent.enable = true;

  xdg.portal = let
    xdph = pkgs.xdg-desktop-portal-hyprland.override {
      hyprland = config.wayland.windowManager.hyprland.finalPackage;
    };
  in {
    configPackages = [config.wayland.windowManager.hyprland.finalPackage];
    extraPortals = [xdph];
  };
  xdg.configFile."hypr/xdph.conf".text = ''
    screencopy {
        allow_token_by_default = true
    }
  '';
}
