{
  hostSpec = {
    name = "yuki";
    kind = "desktop";
    isWork = false;

    cpuThermalZone = null;
    hasDiscreteGPU = true; # AMD Radeon RX 7700 XT
    wlanInterface = "wlp11s0";
    ethernetInterface = "eno1";
    cpuHwmonPath = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
    cpuTempInput = "temp3_input";
  };
}
