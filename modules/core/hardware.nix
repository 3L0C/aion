{ inputs, pkgs, ... }:
let
  hyprland-pkgs =
    inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  hardware = {
    graphics = {
      enable = true;
      package = hyprland-pkgs.mesa;
      enable32Bit = true;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true; # Show battery charge of Bluetooth devices
        };
      };
    };

    uinput.enable = true;
  };

  services.blueman.enable = true;
  hardware.enableRedistributableFirmware = true;
}
