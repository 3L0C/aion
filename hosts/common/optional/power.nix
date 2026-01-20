{
  config,
  lib,
  pkgs,
  ...
}: {
  services.power-profiles-daemon.enable = true;
  services.thermald.enable = lib.mkDefault config.hardware.cpu.intel.updateMicrocode;
  environment.systemPackages = with pkgs; [
    powertop # Power consumption analysis
  ];
}
