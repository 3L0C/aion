{
  programs.waybar = {
    style = ''
      /* Base styling - overriding minimal defaults */
      * {
          border: none;
          border-radius: 0;
          min-height: 0;
      }

      /* Override stylix window background to be fully opaque */
      window#waybar {
          background: @base00;
      }

      /* Left side container - make it flex properly */
      .modules-left {
          margin: 0;
          padding: 0;
      }

      .modules-right {
          padding: 0 5px;
      }

      /* ========== Hyprland workspaces ========== */
      #workspaces {
          margin: 0;
          padding: 0;
      }

      #workspaces button {
          background-color: @base00;
          color: @base05;
          border: none;
          padding: 0 8px;
          margin: 0;
      }

      #workspaces button.active {
          background-color: @base02;
          color: @base05;
      }

      #workspaces button.active:hover {
          background-color: @base02;
          color: @base05;
          box-shadow: none;
          text-shadow: none;
          transition: none;
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
          background-color: @base08;
          color: @base00;
      }

      /* Hyprland custom layout indicator */
      #custom-layout {
          background-color: @base00;
          color: @base05;
          padding: 0 5px;
          margin: 0;
      }

      /* Hyprland submap styling */
      #submap {
          background-color: @base09;
          color: @base00;
          padding: 0 5px;
          margin: 0;
      }

      /* ========== River tags ========== */
      #tags {
          margin: 0;
          padding: 0;
      }

      #tags button {
          background-color: @base00;
          color: @base05;
          border: none;
          padding: 0 8px;
          margin: 0;
      }

      /* River uses .focused instead of .active */
      #tags button.focused {
          background-color: @base02;
          color: @base05;
      }

      #tags button.focused:hover {
          background-color: @base02;
          color: @base05;
          box-shadow: none;
          text-shadow: none;
          transition: none;
          border-color: transparent;
      }

      #tags button:not(.focused):hover {
          box-shadow: none;
          text-shadow: none;
          background: none;
          transition: none;
          border-color: transparent;
      }

      #tags button.urgent {
          background-color: @base08;
          color: @base00;
      }

      /* River layout indicator */
      #layout {
          background-color: @base00;
          color: @base05;
          padding: 0 5px;
          margin: 0;
      }

      /* River mode styling */
      #mode {
          background-color: @base09;
          color: @base00;
          padding: 0 5px;
          margin: 0;
      }

      /* ========== Shared modules ========== */

      /* Window title - dwm style, left aligned */
      #window {
          background-color: @base00;
          color: @base05;
          padding: 0 5px;
          margin: 0;
      }

      #window.focused {
          background-color: @base02;
          color: @base05;
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
      #custom-sb-internet,
      #idle_inhibitor {
          background-color: transparent;
          color: @base05;
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
          color: @base08;
      }

      /* Idle inhibitor states */
      #idle_inhibitor {
          color: @base05;
      }

      #idle_inhibitor.activated {
          color: @base08;
      }

      /* Control Center group */
      #custom-cc-indicator,
      #custom-cc-run {
          background-color: transparent;
          color: @base05;
          padding: 0;
          margin: 0;
      }

      /* MPRIS module */
      #mpris {
          background-color: transparent;
          color: @base05;
          padding: 0;
          margin: 0;
      }

      /* Media controls */
      #custom-media-prev,
      #custom-media-next {
          background-color: transparent;
          color: @base05;
          padding: 0;
          margin: 0;
      }
    '';
  };
}
