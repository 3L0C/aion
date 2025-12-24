{
  hostSpec = {
    name = "nixos-vm";
    kind = "desktop"; # Use desktop to satisfy pc.nix assertions
    isWork = false;

    kbdModel = "pc105";
    kbdLayout = "us";
    kbdVariant = "";

    cpuThermalZone = null;
    hasDiscreteGPU = false; # VM uses virtual GPU
  };
}
