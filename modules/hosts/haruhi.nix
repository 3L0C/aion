{config, ...}: {
  hosts.haruhi = {
    system = "x86_64-linux";
  };

  flake.modules.nixos."hosts/haruhi" = {
    imports = with config.flake.modules.nixos; [
      base
      pc
      kmonad
      lanzaboote
    ];

    hostSpec = {
      name = "haruhi";
      kind = "laptop";
      isWork = false;

      cpuThermalZone = null;
      hasDiscreteGPU = true; # NVIDIA RTX 5070 Ti (Blackwell)

      # Verify interfaces with: ip link
      wlanInterface = "wlo1";
      ethernetInterface = null; # No built-in ethernet.

      # Intel coretemp: temp1 = Package id 0 (overall CPU temperature).
      cpuHwmonPath = "/sys/devices/platform/coretemp.0/hwmon";
      cpuTempInput = "temp1_input";
    };

    system.stateVersion = "26.11";
  };
}
