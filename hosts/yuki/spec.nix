{
  hostSpec = {
    name = "yuki";
    kind = "desktop";
    isWork = false;

    cpuThermalZone = null;
    hasDiscreteGPU = true; # AMD Radeon RX 7800 XT

    wlanInterface = "wlp11s0";
    ethernetInterface = "eno1";

    # AMD k10temp: temp3 = Tctl/Tdie (CPU temperature).
    cpuHwmonPath = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
    cpuTempInput = "temp3_input";
  };
}
