# udev rules for laptop backlight control
{
  flake.modules.nixos.backlight = {
    hardware.acpilight.enable = true;
  };
}
