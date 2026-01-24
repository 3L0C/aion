{
  config,
  lib,
  pkgs,
  ...
}: let
  mod = config.userSpec.modifierKeys.river;
  layoutmsg = msg: "send-layout-cmd rivercarro \"${msg}\"";
in {
  home.packages = [pkgs.rivercarro];
  systemd.user.services.rivercarro = lib.custom.mkWaylandService {
    river = {
      Unit = {
        Description = "Rivercarro layout daemon for River";
        Documentation = "https://sr.ht/~novakane/rivercarro/";
      };

      Service = {
        Type = "simple";
        ExecStart = toString [
          "${lib.getExe pkgs.rivercarro}"
          "-inner-gaps 10"
          "-outer-gaps 20"
          "-main-location left"
          "-main-count 1"
          "-main-ratio 0.6"
          "-per-tag"
          "-no-smart-gaps"
        ];
        Restart = "on-failure";
        RestartSec = "3s";
      };
    };
    riverdev = {
      Unit = {
        Description = "Rivercarro layout daemon for River";
        Documentation = "https://sr.ht/~novakane/rivercarro/";
      };

      Service = {
        Type = "simple";
        ExecStart = toString [
          "${lib.getExe pkgs.rivercarro}"
          "-inner-gaps 10"
          "-outer-gaps 20"
          "-main-location left"
          "-main-count 1"
          "-main-ratio 0.6"
          "-per-tag"
          "-no-smart-gaps"
        ];
        Restart = "on-failure";
        RestartSec = "3s";
      };
    };
  };

  wayland.windowManager.river = {
    settings = {
      default-layout = lib.mkForce "rivercarro"; # namespace

      map.normal = {
        "${mod} Y" = layoutmsg "main-location left";
        "${mod} I" = layoutmsg "main-location monocle";
        "${mod} T" = layoutmsg "main-location top";
      };
    };
  };
}
