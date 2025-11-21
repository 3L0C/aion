{
  imports = [
    ./global

    ./features/cli
    ./features/de
    ./features/dev
  ];
  monitors = [
    {
      name = "DP-3";
      primary = true;
      width = 2560;
      height = 1440;
      refreshRate = 240.0;
      position = "0x0";
      x = 0;
      y = 0;
      scale = "auto";
      enabled = true;
      workspaces = [
        "1"
        "2"
        "3"
        "4"
        "5"
        "6"
        "7"
      ];
    }
    {
      name = "HDMI-A-1";
      primary = false;
      width = 2560;
      height = 1440;
      refreshRate = 143.998;
      position = "2560x0";
      x = 2560;
      y = 0;
      enabled = true;
      workspaces = [
        "8"
        "9"
        "10"
      ];
    }
  ];
}
