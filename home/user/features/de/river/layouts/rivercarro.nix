{
  lib,
  pkgs,
  ...
}: let
  mod = "Super";
  rivercarro = "${lib.getExe pkgs.rivercarro}";
  layoutmsg = msg: "send-layout-cmd rivercarro \"${msg}\"";
in {
  home.packages = [pkgs.rivercarro];

  wayland.windowManager.river = {
    settings = {
      default-layout = lib.mkForce "rivercarro"; # namespace

      map.normal = {
        "${mod} Y" = layoutmsg "main-location left";
        "${mod} I" = layoutmsg "main-location monocle";
        "${mod} T" = layoutmsg "main-location top";
      };
    };

    extraConfig = lib.mkForce ''
      ${rivercarro} \
          -inner-gaps 10 \
          -outer-gaps 10 \
          -main-location left \
          -main-count 1 \
          -main-ratio 0.6 \
          -per-tag \
          -no-smart-gaps \
          &
    '';
  };
}
