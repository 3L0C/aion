{
  stylix.targets.waybar.addCss = true;
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

      /* River tags styling - dwm style tags */
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

      /* Occupied tags get subtle styling */
      /* #tags button.occupied {
       *    background-color: @base00;
       *    color: @base05;
       * }
       */

      #tags button.urgent {
          background-color: @base08;
          color: @base00;
      }

      /* River layout indicator - dwm style */
      #layout {
          background-color: @base00;
          color: @base05;
          padding: 0 5px;
          margin: 0;
      }

      /* River mode styling (like Hyprland submap) */
      #mode {
          background-color: @base09;
          color: @base00;
          padding: 0 5px;
          margin: 0;
      }

      /* Window title - dwm style, left aligned, auto width */
      /* Note: river/window module currently disabled due to segfault bug */
      /* Unfocused monitor - inverted styling */
      #window {
          background-color: @base00;
          color: @base05;
          padding: 0 5px;
          margin: 0;
      }

      /* Focused monitor - normal styling */
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
    '';
  };
}
