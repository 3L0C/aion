{
  flake.modules.homeManager.dunst = {
    services.dunst = {
      enable = true;

      settings = {
        global = {
          monitor = 0;
          follow = "keyboard";
          width = 350;
          height = "(0, 450)";
          offset = "(20, 20)";
          padding = 8;
          horizontal_padding = 8;
          frame_width = 4;
          transparency = 10;
          format = "<b>%s</b>\\n%b";
        };

        urgency_low = {
          timeout = 3;
        };

        urgency_normal = {
          timeout = 5;
        };

        urgency_critical = {
          timeout = 60;
        };
      };
    };
  };
}
