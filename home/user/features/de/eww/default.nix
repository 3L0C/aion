{
  config,
  pkgs,
  ...
}: let
  colors = config.lib.stylix.colors.withHashtag;
  inherit (config.stylix) fonts;
in {
  programs.eww = {
    enable = true;
    package = pkgs.eww;
  };
  home.packages = with pkgs; [
    playerctl
    jq
  ];
  xdg.configFile = {
    "eww/eww.yuck".source = ./config/eww.yuck;
    "eww/scripts/media-players.sh" = {
      source = ./config/scripts/media-players.sh;
      executable = true;
    };
    "eww/eww.scss".text = ''
      // EWW Media Panel Styling
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
        font-size: ${toString fonts.sizes.popups}px;
      }

      .media-panel {
        background-color: $base00;
        border: 2px solid $base0D;
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
    '';
  };
}
