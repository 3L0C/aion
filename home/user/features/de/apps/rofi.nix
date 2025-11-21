{
  config,
  lib,
  pkgs,
  ...
}: {
  stylix.targets.rofi.enable = false;
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-unwrapped.override {
      x11Support = false;
    };

    font = lib.mkForce "${config.stylix.fonts.monospace.name} 14";
    terminal = "${lib.getExe pkgs.kitty}";

    # Basic configuration
    extraConfig = {
      modi = "drun,run,window,ssh";
      display-drun = "Applications";
      display-run = "Run";
      display-window = "Windows";
      display-ssh = "SSH";

      run-command = "uwsm-app -- {cmd}";
      show-icons = false;
      drun-display-format = "{name}";
    };

    # Custom theme matching old rofi config
    # Uses Stylix colors but preserves old layout/sizing
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
      colors = config.lib.stylix.colors.withHashtag;
    in {
      "*" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral colors.base05;

        bg0 = mkLiteral colors.base00;
        bg2 = mkLiteral colors.base02;
        fg0 = mkLiteral colors.base05;
        accent = mkLiteral colors.base0D;
        urgent = mkLiteral colors.base08;
        active = mkLiteral colors.base0B;

        background = mkLiteral "@bg0";
        foreground = mkLiteral "@fg0";
        selected-background = mkLiteral "@bg2";
        selected-foreground = mkLiteral "@accent";
        alternate-background = mkLiteral "transparent";
        border-color = mkLiteral "@accent";
        separatorcolor = mkLiteral "@bg2";
        scrollbar-handle = mkLiteral "@accent";

        border-radius = mkLiteral "0px";
      };

      window = {
        background-color = mkLiteral "@background";
        border = mkLiteral "2px solid";
        border-color = mkLiteral "@border-color";
        border-radius = mkLiteral "0px";
        padding = mkLiteral "0px";
        width = mkLiteral "600px";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
      };

      mainbox = {
        background-color = mkLiteral "transparent";
        children = mkLiteral "[ inputbar, listview ]";
        spacing = mkLiteral "0px";
      };

      inputbar = {
        background-color = mkLiteral "@background";
        text-color = mkLiteral "@fg0";
        border = mkLiteral "0px";
        border-radius = mkLiteral "0px";
        padding = mkLiteral "8px 12px";
        children = mkLiteral "[ entry ]";
      };

      entry = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";
        placeholder-color = mkLiteral "#7c7c7c";
        placeholder = "Search applications...";
        blink = true;
        cursor = mkLiteral "text";
      };

      listview = {
        background-color = mkLiteral "transparent";
        columns = 1;
        lines = 8;
        cycle = false;
        dynamic = true;
        scrollbar = false;
        layout = mkLiteral "vertical";
        reverse = false;
        fixed-height = true;
        spacing = mkLiteral "0px";
      };

      element = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";
        orientation = mkLiteral "horizontal";
        border-radius = mkLiteral "0px";
        padding = mkLiteral "6px 12px";
        margin = mkLiteral "0px";
        cursor = mkLiteral "pointer";
      };

      "element normal.normal" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";
      };

      "element normal.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@bg0";
      };

      "element normal.active" = {
        background-color = mkLiteral "@active";
        text-color = mkLiteral "@bg0";
      };

      "element selected.normal" = {
        background-color = mkLiteral "@bg2";
        text-color = mkLiteral "@fg0";
        border = mkLiteral "0px";
      };

      "element selected.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@bg0";
      };

      "element selected.active" = {
        background-color = mkLiteral "@active";
        text-color = mkLiteral "@bg0";
      };

      "element alternate.normal" = {
        background-color = mkLiteral "@alternate-background";
        text-color = mkLiteral "@fg0";
      };

      "element alternate.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@bg0";
      };

      "element alternate.active" = {
        background-color = mkLiteral "@active";
        text-color = mkLiteral "@bg0";
      };

      element-text = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        highlight = mkLiteral "bold ${colors.base0A}";
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
      };
    };
  };
}
