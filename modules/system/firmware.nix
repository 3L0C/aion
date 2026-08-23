{
  flake.modules.nixos.firmware = {pkgs, ...}: {
    environment.systemPackages = [pkgs.pciutils];
    hardware.enableAllFirmware = true;
  };
}
