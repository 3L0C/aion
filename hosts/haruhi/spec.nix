{
  hostSpec = {
    name = "haruhi";
    kind = "laptop";
    isWork = false;

    kbdModel = "pc105";
    kbdLayout = "us";
    kbdVariant = "";

    cpuThermalZone = null; # Verify with: cat /sys/class/thermal/thermal_zone*/type
    hasDiscreteGPU = true; # NVIDIA RTX 5070 Ti (Blackwell)
    wlanInterface = "wlo1";
    ethernetInterface = null; # No built-in ethernet
    cpuHwmonPath = "/sys/devices/platform/coretemp.0/hwmon";
    cpuTempInput = "temp1_input";
  };
}
