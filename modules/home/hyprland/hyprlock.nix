{
  inputs,
  pkgs,
  ...
}:
{
  programs.hyprlock = {
    enable = true;

    package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;

    settings = {
      general = {
        hide_cursor = false;
      };

      animations = {
        enabled = false;
      };

      background = [
        {
          monitor = "";
          path = "${./1450741833367.jpg}";
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
          color = "rgba(220, 215, 186, 1)";
          font_size = 22;
          font_family = "mono";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%-I:%M")"'';
          color = "rgba(220, 215, 186, 1)";
          font_size = 95;
          font_family = "mono Extrabold";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "250, 60";
          outline_thickness = 2;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8;
          dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          inner_color = "rgba(24, 22, 22, 1)";
          outer_color = "rgba(220, 215, 186, 1)";
          font_color = "rgba(220, 215, 186, 1)";
          fade_on_empty = false;
          rounding = -1;
          check_color = "rgb(127, 180, 202)";
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
