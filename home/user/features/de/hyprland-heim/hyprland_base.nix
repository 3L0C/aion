{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
  };
  home.packages = with pkgs; [
    grimblast # from nixpkgs, not hypr-contrib flake
    hyprpicker # from nixpkgs, not flake
    grim
    slurp
    wl-clip-persist
    cliphist
    wf-recorder
    glib
    wayland
    direnv
  ];
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
