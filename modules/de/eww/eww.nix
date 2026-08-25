# EWW (ElKowar's Wacky Widgets)
# - Media panel: Shows all active MPRIS players with prev/play-pause/next controls
# - Control Center: Modular widget system with host-specific layouts
{
  flake.modules.homeManager.eww =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      colors = config.lib.stylix.colors.withHashtag;
      inherit (config.stylix) fonts;

      isLaptop = config.hostSpec.kind == "laptop";
      primaryMonitorName = config.primaryMonitor.name;

      polls = {
        cc-state = ''
          (defpoll cc-state :interval "1s"
            "~/.config/eww/scripts/control-center.sh")
        '';

        power-profile = ''
          (defpoll power-profile :interval "2s"
            "~/.config/eww/scripts/power-profile.sh")
        '';

        touchpad-state = ''
          (defpoll touchpad-state :interval "1s"
            "cat $XDG_RUNTIME_DIR/touchpad-state 2>/dev/null || echo enabled")
        '';
      };

      widgets = {
        volume-control = {
          requires = [ "cc-state" ];
          definition = ''
            (defwidget volume-control []
              (eventbox :onrightclick "kitty --class pulsemixer pulsemixer &"
                (box :class "cc-row"
                     :orientation "horizontal"
                     :space-evenly false
                  (button :class "cc-btn"
                          :onclick "pamixer -d 5"
                    "")
                  (label :class "cc-text"
                         :hexpand true
                         :text {cc-state.muted ? "MUTED" : "vol: ''${cc-state.volume}%"})
                  (button :class "cc-btn"
                          :onclick "pamixer -i 5"
                    ""))))
          '';
        };

        backlight-control = {
          requires = [ "cc-state" ];
          definition = ''
            (defwidget backlight-control []
              (box :class "cc-row"
                   :orientation "horizontal"
                   :space-evenly false
                (button :class "cc-btn"
                        :onclick "brightnessctl --device=intel_backlight set 5%-"
                  "󰌶")
                (label :class "cc-text"
                       :hexpand true
                       :text {cc-state.backlight != "null" ? "bkl: ''${cc-state.backlight}%" : "bkl: N/A"})
                (button :class "cc-btn"
                        :onclick "brightnessctl --device=intel_backlight set +5%"
                  "󰌵")))
          '';
        };

        power-profile-control = {
          requires = [ "power-profile" ];
          definition = ''
            (defwidget power-profile-control []
              (box :class "cc-row cc-power-row"
                   :orientation "horizontal"
                   :space-evenly true
                (button :class {power-profile == "Quiet" ? "cc-btn cc-power cc-active" : "cc-btn cc-power"}
                        :onclick "asusctl profile -P Quiet"
                        :tooltip "Quiet - Low power, silent fans"
                  "󰌪")
                (button :class {power-profile == "Balanced" ? "cc-btn cc-power cc-active" : "cc-btn cc-power"}
                        :onclick "asusctl profile -P Balanced"
                        :tooltip "Balanced - Normal performance"
                  "󰾅")
                (button :class {power-profile == "Performance" ? "cc-btn cc-power cc-active" : "cc-btn cc-power"}
                        :onclick "asusctl profile -P Performance"
                        :tooltip "Performance - Maximum power"
                  "")))
          '';
        };
      };

      quickActionButtons = {
        search = {
          requires = [ ];
          definition = ''
            (button :class "cc-btn cc-action"
                    :onclick "eww close control-center && rofi -show drun &"
              "")
          '';
        };

        touchpad = {
          requires = [ "touchpad-state" ];
          definition = ''
            (button :class "cc-btn cc-action"
                    :onclick "touchpad-toggle"
                    :tooltip {touchpad-state == "disabled" ? "Touchpad disabled - click to enable" : "Touchpad enabled - click to disable"}
              {touchpad-state == "disabled" ? "󰤳" : "󰟸"})
          '';
        };
      };

      layouts = {
        laptop = {
          widgets = [
            "volume-control"
            "backlight-control"
            "power-profile-control"
          ];
          quickActions = [
            "search"
            "touchpad"
          ];
        };

        desktop = {
          widgets = [ "volume-control" ];
          quickActions = [ "search" ];
        };
      };

      currentLayout = if isLaptop then layouts.laptop else layouts.desktop;

      collectPolls =
        layout:
        let
          widgetPolls = lib.concatMap (w: widgets.${w}.requires) layout.widgets;
          buttonPolls = lib.concatMap (b: quickActionButtons.${b}.requires) layout.quickActions;
        in
        lib.unique (widgetPolls ++ buttonPolls);

      generatePolls = pollNames: lib.concatStringsSep "\n" (map (p: polls.${p}) pollNames);

      generateWidgets =
        widgetNames: lib.concatStringsSep "\n" (map (w: widgets.${w}.definition) widgetNames);

      generateQuickActions = buttonNames: ''
        (defwidget quick-actions []
          (box :class "cc-row"
               :orientation "horizontal"
               :space-evenly true
            ${lib.concatStringsSep "\n    " (map (b: quickActionButtons.${b}.definition) buttonNames)}))
      '';

      generateContentWidget = layout: ''
        (defwidget control-center-content []
          (eventbox :onrightclick "eww close control-center"
            (box :class "control-panel"
                 :orientation "vertical"
                 :space-evenly false
              ${lib.concatStringsSep "\n      " (map (w: "(${w})") layout.widgets)}
              (quick-actions))))
      '';

      controlCenterYuck =
        let
          requiredPolls = collectPolls currentLayout;
        in
        ''
          ; EWW Control Center - Dynamically generated
          ; Layout: ${if isLaptop then "laptop" else "desktop"}

          ; Polls
          ${generatePolls requiredPolls}

          ; Window definition
          (defwindow control-center
            :monitor "${primaryMonitorName}"
            :geometry (geometry
              :x "20px"
              :y "20px"
              :width "200px"
              :anchor "top right")
            :stacking "fg"
            :exclusive false
            :focusable false
            (control-center-content))

          ; Widget definitions
          ${generateWidgets currentLayout.widgets}

          ; Quick actions row
          ${generateQuickActions currentLayout.quickActions}

          ; Main content container
          ${generateContentWidget currentLayout}
        '';
    in
    {
      programs.eww = {
        enable = true;
        package = pkgs.eww;
      };

      home.packages =
        with pkgs;
        [
          playerctl
          jq
          pamixer
          brightnessctl
        ]
        ++ lib.optional isLaptop asusctl;

      xdg.configFile = {
        "eww/media-panel.yuck".text = ''
          ; EWW Media Panel - Shows all active MPRIS players
          ; Triggered from waybar, displays vertically stacked player controls

          ; Poll for active media players every second
          (defpoll media-players :interval "1s"
            "~/.config/eww/scripts/media-players.sh")

          ; Main media panel window
          (defwindow media-panel
            :monitor "${primaryMonitorName}"
            :geometry (geometry
              :x "20px"
              :y "20px"
              :width "350px"
              :anchor "top right")
            :stacking "fg"
            :exclusive false
            :focusable false
            (media-panel-content))

          ; Container widget - right-click anywhere to close
          (defwidget media-panel-content []
            (eventbox :onrightclick "eww close media-panel"
              (box :class "media-panel"
                   :orientation "vertical"
                   :space-evenly false
                (for player in media-players
                  (player-row :data player)))))

          ; Individual player row with prev/info/play-pause/next
          (defwidget player-row [data]
            (box :class "player-row"
                 :orientation "horizontal"
                 :space-evenly false
              ; Prev button
              (button :class "player-btn"
                      :onclick "playerctl --player=''${data.player} previous"
                "󰒮")
              ; Media title - click to toggle play/pause
              (eventbox :onclick "playerctl --player=''${data.player} play-pause"
                        :hexpand true
                (label :class "player-info"
                       :text "''${data.display}"))
              ; Play/pause button
              (button :class "player-btn"
                      :onclick "playerctl --player=''${data.player} play-pause"
                "''${data.icon}")
              ; Next button
              (button :class "player-btn"
                      :onclick "playerctl --player=''${data.player} next"
                "󰒭")))
        '';

        "eww/control-center.yuck".text = controlCenterYuck;

        "eww/eww.yuck".text = ''
          ; EWW Configuration - Import all panels
          (include "./media-panel.yuck")
          (include "./control-center.yuck")
        '';

        "eww/scripts/media-players.sh" = {
          source = ./scripts/media-players.sh;
          executable = true;
        };

        "eww/scripts/control-center.sh" = {
          source = ./scripts/control-center.sh;
          executable = true;
        };

        "eww/scripts/power-profile.sh" = lib.mkIf isLaptop {
          source = ./scripts/power-profile.sh;
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
    };
}
