{
  flake.modules.homeManager.openlogi = { pkgs, ... }: {
    home.packages = with pkgs; [
      openlogi # Local-first companion for Logitech HID++ peripherals
    ];
  };
}
