{
  config,
  pkgs,
  lib,
  ...
}: let
  wallpaper = config.userSpec.theme.wallpaper;
in {
  home.packages = [pkgs.swaybg];

  systemd.user.services.swaybg = lib.custom.mkWaylandService {
    river = {
      Unit.Description = "swaybg wallpaper daemon";
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.swaybg}/bin/swaybg --mode fill --image ${wallpaper}";
        Restart = "on-failure";
      };
    };
  };
}
