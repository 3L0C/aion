{lib, ...}: {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        ignore_empty_input = true;
        hide_cursor = true;
        grace = 0;
      };

      animations = {
        enabled = false;
      };

      background = lib.mkDefault [
        {
          monitor = "";
          path = "${../1450741833367.jpg}";
          blur_passes = 1;
          contrast = 1;
          brightness = 0.5;
          vibrancy = 0.2;
          vibrancy_darkness = 0.2;
        }
      ];

      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
          font_size = 22;
          font_family = "mono";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%-I:%M")"'';
          font_size = 95;
          font_family = "monospace Extrabold";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = lib.mkDefault [
        {
          monitor = "";
          size = "250, 60";
          outline_thickness = 2;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8;
          dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          fade_on_empty = false;
          rounding = -1;
          placeholder_text = "<i><span>Input Password...</span></i>";
          hide_input = false;
          position = "0, -200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
