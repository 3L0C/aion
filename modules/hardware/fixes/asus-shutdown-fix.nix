# Fix for ASUS laptops that hang at "shutdown[1]: Powering off."
{
  flake.modules.nixos.asus-shutdown-fix = {
    boot = {
      kernelParams = [
        # Force ACPI power management (helps with ASUS firmware)
        "acpi=force"

        # If the hang persists, also try:
        # "reboot=acpi"
      ];

      # Intel ME interface is a common cause of shutdown hangs and is not needed
      # for normal operation.
      blacklistedKernelModules = ["mei_me"];
    };
  };
}
