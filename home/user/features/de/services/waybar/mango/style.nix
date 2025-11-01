{config, ...}: {
  xdg.configFile."waybar/mango-style.css".text = ''
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
        font-family: "${config.themeSpec.fonts.mono}";
        font-size: 18px;
        min-height: 0;
    }

    window#waybar {
        background-color: @background;
        color: @foreground;
    }

    /* Left side container */
    .modules-left {
        margin: 0;
        padding: 0;
    }

    .modules-right {
        padding: 0 5px;
    }

    /* DWL Tags styling (like dwm workspaces) */
    #tags {
        margin: 0;
        padding: 0;
    }

    #tags button {
        background-color: @background;
        color: @foreground;
        border: none;
        padding: 0 8px;
        margin: 0;
    }

    #tags button.active {
        background-color: @background-light;
        color: @foreground;
    }

    #tags button.active:hover {
        background-color: @background-light;
        color: @foreground;
        box-shadow: none;
        text-shadow: none;
        transition: none;
        background: @background-light;
        border-color: transparent;
    }

    #tags button:not(.active):hover {
        box-shadow: none;
        text-shadow: none;
        background: none;
        transition: none;
        border-color: transparent;
    }

    #tags button.urgent {
        background-color: @red;
        color: @background;
    }

    /* Window title and layout - dwm style */
    #window {
        background-color: @background-light;
        color: @foreground;
        padding: 0 5px;
        margin: 0;
    }

    /* Right side modules */
    #custom-sb-playerctl,
    #custom-sb-mpv,
    #pulseaudio,
    #temperature,
    #cpu,
    #memory,
    #custom-sb-internet,
    #network,
    #clock,
    #idle_inhibitor,
    #tray {
        background-color: @background;
        color: @foreground;
        padding: 0 5px;
    }

    #pulseaudio.muted {
        color: @red;
    }

    #temperature.critical {
        color: @red;
    }

    #idle_inhibitor.activated {
        color: @green;
    }

    #tray > .passive {
        -gtk-icon-effect: dim;
    }

    #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: @red;
    }
  '';
}
