{lib, ...}: {
  imports = [
    ./global

    ./features/cli
    ./features/de
    ./features/dev

    ./features/de/river
  ];
  monitors = [
    {
      name = "eDP-1"; # Internal laptop display
      primary = true;
      width = 2560;
      height = 1600; # 16:10 aspect ratio
      refreshRate = 240.0;
      position = "0x0";
      x = 0;
      y = 0;
      scale = "1.5"; # HiDPI scaling for 16" 2.5K
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
        "8"
        "9"
        "10"
      ];
      transform = "normal";
    }
  ];
  userSpec = {
    kbdOptions = "";
    kmonadDevice = "/dev/input/by-id/usb-ITE_Tech._Inc._ITE_Device_8910_-event-mouse";
    kmonadConfig = lib.fileContents ../../hosts/common/optional/kmonad/g16.kbd;
  };
}
