# Home configuration for yuki (desktop)
{
  flake.modules.homeManager."hosts/yuki" = {
    # Base layout ("all" / work): HP far-left, BenQ center, AOC primary far-right.
    # Alternate layout ("gaming"): HP far-left, AOC primary center, BenQ far-right.
    # All three outputs have logical width 2560 (BenQ's 3840 ÷ 1.5 scale).
    monitors = [
      {
        name = "HDMI-A-1"; # HP Omen
        primary = false;
        width = 2560;
        height = 1440;
        refreshRate = 143.998993;
        position = "0x0";
        x = 0;
        y = 0;
        scale = "auto";
        enabled = true;
        workspaces = [
          "11"
          "12"
          "13"
        ];
        transform = "normal";
      }
      {
        name = "DP-3"; # BenQ RD280UG (center in work layout)
        primary = false;
        width = 3840;
        height = 2560;
        refreshRate = 119.990997;
        position = "2560x0";
        x = 2560;
        y = 0;
        scale = "1.5";
        enabled = true;
        workspaces = [
          "8"
          "9"
          "10"
        ];
        transform = "normal";
      }
      {
        name = "DP-1"; # AOC Q27G41ZDF (primary; far-right in work, center in gaming)
        primary = true;
        width = 2560;
        height = 1440;
        refreshRate = 240.0;
        position = "5120x0";
        x = 5120;
        y = 0;
        scale = "auto";
        enabled = true;
        isOLED = true; # Enable burn-in mitigation
        workspaces = [
          "1"
          "2"
          "3"
          "4"
          "5"
          "6"
          "7"
        ];
        transform = "normal";
      }
    ];

    monitorLayouts.gaming = {
      "DP-1" = {
        x = 2560;
        y = 0;
      };
      "DP-3" = {
        x = 5120;
        y = 0;
      };
      # HDMI-A-1 stays at 0,0
    };
  };
}
