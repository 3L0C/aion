{
  imports = [
    ./global

    ./features/cli
    ./features/de
    ./features/dev

    ./features/de/river
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
    {
      name = "DP-1";
      primary = false;
      width = 2560;
      height = 1440;
      refreshRate = 239.998001;
      position = "2560x0";
      x = 2560;
      y = 0;
      enabled = true;
      workspaces = [
        "8"
        "9"
        "10"
      ];
      transform = "normal";
    }
  ];
}
