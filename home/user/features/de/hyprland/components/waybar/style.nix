{config, ...}: {
  programs.waybar = {
    style = ''
      /* Kanagawa Colors - from themeSpec */
      @define-color background ${config.themeSpec.background};
      @define-color background-light ${config.themeSpec.colors.base4};
      @define-color foreground ${config.themeSpec.foreground};
      @define-color black ${config.themeSpec.terminal.color0};
      @define-color red ${config.themeSpec.colors.red};
      @define-color green ${config.themeSpec.colors.green};
      @define-color yellow ${config.themeSpec.colors.yellow};
      @define-color blue ${config.themeSpec.colors.blue};
      @define-color magenta ${config.themeSpec.colors.magenta};
      @define-color cyan ${config.themeSpec.colors.cyan};
      @define-color white ${config.themeSpec.foreground};
      @define-color orange ${config.themeSpec.colors.orange};

      * {
          border: none;
          border-radius: 0;
          font-family: "monospace";
          font-size: 18px;
          min-height: 0;
      }

      window#waybar {
          background-color: @background;
          color: @foreground;
      }

      /* Left side container - make it flex properly */
      .modules-left {
          margin: 0;
          padding: 0;
      }

      .modules-right {
          padding: 0 5px;
      }

      /* Workspaces styling - dwm style tags */
      #workspaces {
          margin: 0;
          padding: 0;
      }

      #workspaces button {
          background-color: @background;
          color: @foreground;
          border: none;
          padding: 0 8px;
          margin: 0;
      }

      #workspaces button.active {
          background-color: @background-light;
          color: @foreground;
      }

      #workspaces button.active:hover {
          background-color: @background-light;
          color: @foreground;
          box-shadow: none;
          text-shadow: none;
          transition: none;
          background: @background-light;
          border-color: transparent;
      }

      #workspaces button:not(.active):hover {
          box-shadow: none;
          text-shadow: none;
          background: none;
          transition: none;
          border-color: transparent;
      }

      #workspaces button.urgent {
          background-color: @red;
          color: @background;
      }

      /* Layout indicator - dwm style */
      #custom-layout {
          background-color: @background;
          color: @foreground;
          padding: 0 5px;
          margin: 0;
      }

      /* Window title - dwm style, left aligned, auto width */
      #window {
          background-color: @background-light;
          color: @foreground;
          padding: 0 5px;
          margin: 0;
      }

      /* Submap styling */
      #submap {
          background-color: @orange;
          color: @background;
          padding: 0 5px;
          margin: 0;
      }

      /* Right side modules - status bar style */
      #custom-sb-playerctl,
      #custom-sb-mpv,
      #pulseaudio,
      #temperature,
      #memory,
      #custom-weather,
      #network,
      #clock,
      #cpu,
      #battery,
      #backlight,
      #disk,
      #custom-uptime,
      #custom-updates,
      #custom-quote,
      #idle_inhibitor {
          background-color: transparent;
          color: @foreground;
          padding: 0;
          margin: 0;
      }

      /* Tray styling */
      #tray {
          background-color: transparent;
          padding: 0 5px;
          margin: 0;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          color: @red;
      }

      /* Idle inhibitor states */
      #idle_inhibitor {
          color: @foreground;
      }

      #idle_inhibitor.activated {
          color: @red;
      }
    '';
  };
}
