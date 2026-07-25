{lib, ...}: {
  imports = [
    ./global

    ./features/cli
    ./features/de
    ./features/dev

    ./features/de/river
    ./features/de/hyprland
    ./features/de/niri
    ./features/de/kde
  ];

  # Single virtual monitor
  monitors = [
    {
      name = "Virtual-1";
      primary = true;
      width = 1920;
      height = 1080;
      refreshRate = 60.0;
      autoResolution = false; # Use explicit resolution for VM
      position = "0x0";
      x = 0;
      y = 0;
      scale = "1";
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
  userSpec.modifierKeys = lib.mkForce {
    river = "Super+Control";
    river-classic = "Super+Control";
    hyprland = "SUPER_CONTROL";
    niri = "Mod+Ctrl";
  };
}
