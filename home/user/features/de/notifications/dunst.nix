{config, ...}: {
  services.dunst = {
    enable = true;

    settings = {
      global = {
        monitor = 0;
        follow = "keyboard";
        width = 350;
        height = "(0, 450)";
        offset = "(0, 30)";
        padding = 8;
        horizontal_padding = 8;
        frame_width = 3;
        transparency = 10;
        font = "monospace 13";
        format = "<b>%s</b>\\n%b";
      };

      urgency_low = {
        inherit (config.themeSpec) foreground background;
        timeout = 3;
      };

      urgency_normal = {
        inherit (config.themeSpec) foreground background;
        frame_color = config.themeSpec.info;
        timeout = 5;
      };

      urgency_critical = {
        inherit (config.themeSpec) foreground background;
        frame_color = config.themeSpec.urgent;
        timeout = 60;
      };
    };
  };
}
