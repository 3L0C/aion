# haruhi: ASUS ROG Zephyrus G16 2025 (GU605CR)
{
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
}
