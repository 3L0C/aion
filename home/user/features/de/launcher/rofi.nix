{config, ...}: let
  inherit (config.themeSpec) accent urgent active;
  bg = config.themeSpec.background;
  bgSelected = config.themeSpec.colors.base4;
  fg = config.themeSpec.foreground;
in {
  programs.rofi = {
    enable = true;

    # Basic configuration
    extraConfig = {
      show-icons = false;
      icon-theme = "Papirus";
      display-drun = "Applications";
      display-run = "Run";
      display-window = "Windows";
      drun-display-format = "{name}";
      font = "mono 14";
    };
    theme = {
      "*" = {
        background-color = "transparent";
        text-color = fg;
        bg0 = bg;
        bg1 = bgSelected;
        fg0 = fg;
        accent-color = accent;
        urgent-color = urgent;
        active-color = active;
        background = bg;
        foreground = fg;
        selected-background = bgSelected;
        selected-foreground = accent;
        alternate-background = "transparent";
        border-color = accent;
        separatorcolor = bgSelected;
        scrollbar-handle = accent;

        font = "mono 14";
        border-radius = "0px";
      };

      window = {
        background-color = bg;
        border = "2px solid";
        border-color = accent;
        border-radius = "0px";
        padding = "0px";
        width = "600px";
        location = "center";
        anchor = "center";
      };

      mainbox = {
        background-color = "transparent";
        children = "[inputbar, listview]";
        spacing = "0px";
      };

      inputbar = {
        background-color = bg;
        text-color = fg;
        border = "0px";
        border-radius = "0px";
        padding = "8px 12px";
        children = "[entry]";
      };

      prompt = {
        background-color = "transparent";
        text-color = accent;
        font = "mono 14";
        margin = "0px 8px 0px 0px";
      };

      textbox-prompt-colon = {
        expand = false;
        str = "";
        background-color = "transparent";
        text-color = accent;
      };

      entry = {
        background-color = "transparent";
        text-color = fg;
        placeholder-color = "#7c7c7c";
        placeholder = "Search applications...";
        blink = true;
        cursor = "text";
      };

      listview = {
        background-color = "transparent";
        columns = 1;
        lines = 8;
        cycle = false;
        dynamic = true;
        scrollbar = false;
        layout = "vertical";
        reverse = false;
        fixed-height = true;
        spacing = "0px";
      };

      scrollbar = {
        width = "4px";
        border = "0px";
        handle-color = accent;
        handle-width = "4px";
        padding = "0px";
        margin = "0px 0px 0px 8px";
        background-color = bgSelected;
        border-radius = "2px";
      };

      element = {
        background-color = "transparent";
        text-color = fg;
        orientation = "horizontal";
        border-radius = "0px";
        padding = "6px 12px";
        margin = "0px";
        cursor = "pointer";
      };

      "element normal.normal" = {
        background-color = "transparent";
        text-color = fg;
      };

      "element normal.urgent" = {
        background-color = urgent;
        text-color = bg;
      };

      "element normal.active" = {
        background-color = active;
        text-color = bg;
      };

      "element selected.normal" = {
        background-color = bgSelected;
        text-color = fg;
        border = "0px";
      };

      "element selected.urgent" = {
        background-color = urgent;
        text-color = bg;
      };

      "element selected.active" = {
        background-color = active;
        text-color = bg;
      };

      "element alternate.normal" = {
        background-color = "transparent";
        text-color = fg;
      };

      "element alternate.urgent" = {
        background-color = urgent;
        text-color = bg;
      };

      "element alternate.active" = {
        background-color = active;
        text-color = bg;
      };

      element-icon = {
        background-color = "transparent";
        size = "24px";
        margin = "0px 8px 0px 0px";
        cursor = "inherit";
      };

      element-text = {
        background-color = "transparent";
        text-color = "inherit";
        highlight = "bold ${config.themeSpec.colors.yellow}";
        cursor = "inherit";
        vertical-align = "0.5";
      };

      mode-switcher = {
        background-color = "transparent";
        spacing = "8px";
      };

      button = {
        background-color = bgSelected;
        text-color = fg;
        border = "0px";
        border-radius = "6px";
        padding = "8px 16px";
        margin = "0px";
        cursor = "pointer";
        font = "mono 14";
      };

      "button selected" = {
        background-color = accent;
        text-color = bg;
        font = "mono 14";
      };

      message = {
        background-color = bgSelected;
        border = "0px";
        border-radius = "0px";
        padding = "12px";
        margin = "0px 0px 15px 0px";
      };

      textbox = {
        background-color = "transparent";
        text-color = fg;
        vertical-align = "0.5";
        horizontal-align = "0.0";
        highlight = "none";
        blink = true;
        markup = true;
      };

      error-message = {
        background-color = urgent;
        text-color = bg;
        border-radius = "0px";
        padding = "12px";
      };
    };
  };
}
