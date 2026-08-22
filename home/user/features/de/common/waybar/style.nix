# Shared Waybar dwm style statusbar
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

      /* Layout indicator */
      #custom-layout {
          background-color: @base00;
          color: @base05;
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
      #custom-mpris,
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
          color: @base0A;
      }

      /* Control Center group */
      #custom-cc-indicator,
      #custom-cc-run,
      #custom-vol-up,
      #custom-vol-down,
      #custom-bkl-up,
      #custom-bkl-down {
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

      /* ========== oxbow (river 0.4.x) oxctl modules ========== */

      /* Vacant tags are hidden (tag.sh emits empty text); with --show-empty
       * they render dimmed via this base style. State classes come from the
       * scripts' JSON. */
      #custom-tag {
          background-color: @base00;
          color: @base04;
          padding: 0 8px;
          margin: 0;
      }

      #custom-tag.occupied {
          color: @base05;
      }

      /* The output's viewed tag set (river/tags' "focused" look) */
      #custom-tag.viewed {
          background-color: @base02;
          color: @base05;
      }

      /* Tags of the focused window; combines with .viewed's background */
      #custom-tag.focused {
          color: @base0A;
      }

      #custom-tag.urgent {
          background-color: @base08;
          color: @base00;
      }

      #custom-layout {
          background-color: @base00;
          color: @base05;
          padding: 0 5px;
          margin: 0;
      }

      #custom-mode {
          background-color: @base09;
          color: @base00;
          padding: 0 5px;
          margin: 0;
      }

      #custom-window {
          background-color: @base00;
          color: @base05;
          padding: 0 5px;
          margin: 0;
      }

      /* A seat is on this output */
      #custom-window.focused {
          background-color: @base02;
          color: @base05;
      }

      #custom-capture {
          padding: 0;
          margin: 0;
      }

      /* The output has a capture session */
      #custom-capture.recording {
          background-color: @base08;
          color: @base00;
          padding: 0 5px;
          margin: 0 5px;
      }
    '';
  };
}
