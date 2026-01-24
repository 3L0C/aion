{
  hostSpec = {
    name = "nixos-vm";
    kind = "desktop"; # Use desktop to satisfy pc.nix assertions
    isWork = false;

    cpuThermalZone = null;
    hasDiscreteGPU = false; # VM uses virtual GPU
  };
}
