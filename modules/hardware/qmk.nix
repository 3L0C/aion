# udev rules for flashing QMK keyboards (the qmk CLI lives in the
# dev aspect)
{
  flake.modules.nixos.qmk = {
    hardware.keyboard.qmk.enable = true;
  };
}
