{
  flake.modules.nixos.power =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      # power-profiles-daemon integrates with asusctl/asusd. It disables TLP
      # (enabled by nixos-hardware common-pc-laptop) to avoid conflicts.
      services.power-profiles-daemon.enable = true;

      # thermald works alongside power-profiles-daemon on Intel CPUs
      services.thermald.enable = lib.mkDefault config.hardware.cpu.intel.updateMicrocode;

      environment.systemPackages = with pkgs; [
        powertop # Power consumption analysis
      ];
    };
}
