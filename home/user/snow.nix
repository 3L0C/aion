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
      width = 2560;
      height = 1440;
      refreshRate = 240;
      workspaces = ["1" "2" "3" "4" "5" "6" "7"];
      primary = true;
      position = "0x0";
    }
    {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      refreshRate = 240;
      workspaces = ["8" "9" "10"];
      primary = false;
      position = "2560x0";
    }
  ];
}
