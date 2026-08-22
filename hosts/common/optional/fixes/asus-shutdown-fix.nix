# Fix for ASUS laptops that hang at "shutdown[1]: Powering off."
{
  boot = {
    kernelParams = [
      # Force ACPI power management (helps with ASUS firmware)
      "acpi=force"

      # If the hang persists, also try:
      # "reboot=acpi"
    ];
    blacklistedKernelModules = ["mei_me"];
  };
}
