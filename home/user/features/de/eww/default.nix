{
  config,
  lib,
  pkgs,
  ...
}: let
  colors = config.lib.stylix.colors.withHashtag;
  inherit (config.stylix) fonts;
  isLaptop = config.hostSpec.kind == "laptop";
  controlCenterContent = ''
    ; Container widget - right-click anywhere to close
    (defwidget control-center-content []
      (eventbox :onrightclick "eww close control-center"
        (box :class "control-panel"
             :orientation "vertical"
             :space-evenly false
          (volume-control)
          ${lib.optionalString isLaptop "(backlight-control)\n      (power-profile-control)\n      (quick-actions-laptop)"}
          ${lib.optionalString (!isLaptop) "(quick-actions)"})))
  '';
in {
  programs.eww = {
    enable = true;
    package = pkgs.eww;
  };
  home.packages = with pkgs;
    [
      playerctl
      jq
      pamixer
      brightnessctl
    ]
    ++ lib.optional isLaptop asusctl;
  xdg.configFile = {
    "eww/eww.yuck".text =
      builtins.readFile ./config/eww.yuck
      + "\n"
      + builtins.readFile ./config/control-center.yuck
      + "\n"
      + controlCenterContent
      + lib.optionalString isLaptop ("\n" + builtins.readFile ./config/control-center-laptop.yuck);
    "eww/scripts/media-players.sh" = {
      source = ./config/scripts/media-players.sh;
      executable = true;
    };
    "eww/scripts/control-center.sh" = {
      source = ./config/scripts/control-center.sh;
      executable = true;
    };
    "eww/scripts/power-profile.sh" = lib.mkIf isLaptop {
      source = ./config/scripts/power-profile.sh;
      executable = true;
    };
    "eww/eww.scss".text = ''
      // EWW Styling - Media Panel and Control Center
      // Colors from stylix (base16)
      $base00: ${colors.base00};
      $base01: ${colors.base01};
      $base02: ${colors.base02};
      $base03: ${colors.base03};
      $base04: ${colors.base04};
      $base05: ${colors.base05};
      $base06: ${colors.base06};
      $base07: ${colors.base07};
      $base08: ${colors.base08};
      $base09: ${colors.base09};
      $base0A: ${colors.base0A};
      $base0B: ${colors.base0B};
      $base0C: ${colors.base0C};
      $base0D: ${colors.base0D};
      $base0E: ${colors.base0E};
      $base0F: ${colors.base0F};

      * {
        all: unset;
        font-family: "${fonts.monospace.name}", monospace;
        font-size: ${toString (fonts.sizes.terminal + 4)}px;
      }

      // Media Panel
      .media-panel {
        background-color: $base00;
        border: 4px solid $base0D;
        border-radius: 0px;
        padding: 6px;
      }

      .player-row {
        background-color: $base00;
        color: $base05;
        padding: 4px 6px;
        border-bottom: 1px solid $base02;

        &:last-child {
          border-bottom: none;
        }
      }

      .player-info {
        color: $base05;
        margin: 0 8px;

        &:hover {
          color: $base0D;
        }
      }

      .player-btn {
        color: $base05;
        padding: 2px 6px;
        border-radius: 2px;

        &:hover {
          color: $base0D;
          background-color: $base01;
        }
      }

      // Control Center Panel
      .control-panel {
        background-color: $base00;
        border: 4px solid $base0D;
        border-radius: 0px;
        padding: 6px;
      }

      .cc-row {
        background-color: $base00;
        color: $base05;
        padding: 6px 8px;
        border-bottom: 1px solid $base02;

        &:last-child {
          border-bottom: none;
        }
      }

      .cc-btn {
        color: $base05;
        padding: 4px 10px;
        border-radius: 2px;
        min-width: 28px;
        min-height: 28px;

        &:hover {
          color: $base0D;
          background-color: $base01;
        }
      }

      .cc-text {
        color: $base05;
        padding: 0 8px;
      }

      .cc-action {
        font-size: ${toString (fonts.sizes.terminal + 6)}px;
      }

      // Power profile buttons (laptop)
      .cc-power-row {
        padding: 8px;
      }

      .cc-power {
        font-size: ${toString (fonts.sizes.terminal + 8)}px;
        padding: 8px 12px;
      }

      .cc-active {
        color: $base0D;
        background-color: $base01;
      }
    '';
  };
}
