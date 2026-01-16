{
  boot = {
    kernelParams = [
      # Force ACPI power management (helps with ASUS firmware)
      "acpi=force"
    ];
    blacklistedKernelModules = ["mei_me"];
  };
}
