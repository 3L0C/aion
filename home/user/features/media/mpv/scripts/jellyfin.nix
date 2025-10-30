{ lib, pkgs, secrets, ... }:
let
  mpv-jellyfin = pkgs.callPackage (lib.custom.relativeToRoot "pkgs/mpv/scripts/jellyfin.nix") {  };

in
{
  programs.mpv = {
    scriptOpts = {
      jellyfin = {
        url = "https://jellyfin.colebruns.com";
        username = "cole";
        password = secrets.jellyfin.password or "CHANGEME";
        image_path = "/tmp/mpv-jellyfin";
        hide_images = "off";
        hide_spoilers = "on";
        show_by_default = "off";
        show_on_idle = "on";
        use_playlist = "on";
        colour_default = "FFFFFF";
        colour_selected = "FF0000";
        colour_watched = "FF00";
      };
    };
  };
}
