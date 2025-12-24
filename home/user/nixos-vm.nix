{
  imports = [
    ./global

    ./features/cli
    ./features/de
    ./features/dev
  ];

  # Single virtual monitor
  monitors = [
    {
      name = "Virtual-1";
      primary = true;
      width = 1920;
      height = 1080;
      refreshRate = 60.0;
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
        "8"
        "9"
        "10"
      ];
      transform = "normal";
    }
  ];
}
