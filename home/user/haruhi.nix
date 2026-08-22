# Home configuration for haruhi (laptop)
# ASUS ROG Zephyrus G16 2025 (GU605CR)
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
      name = "eDP-1";
      primary = true;
      width = 2560;
      height = 1600;
      refreshRate = 240.0;
      position = "0x0";
      x = 0;
      y = 0;
      scale = "1.5";
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

  # kmonad maps caps to esc/shift. Do not set the XKB swap.
  userSpec = {
    kbdOptions = "";
    kmonadDevice = "/dev/input/by-id/usb-ITE_Tech._Inc._ITE_Device_8910_-event-mouse";
    kmonadConfig = lib.fileContents ../../hosts/common/optional/kmonad/g16.kbd;
  };
}
