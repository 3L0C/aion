{ config, ... }:
let
  hm = config.flake.modules.homeManager;
in
{
  hosts.yuki = {
    system = "x86_64-linux";
  };

  flake.modules.nixos."hosts/yuki" = {
    imports = with config.flake.modules.nixos; [
      base
      pc
      lanzaboote
      usb-wake-fix
      amdgpu-sdma-fix
      ollama
      open-webui
      syncthing-ports
    ];

    hostSpec = {
      name = "yuki";
      kind = "desktop";
      isWork = false;
      primaryUser = "user"; # Primary administrator account

      cpuThermalZone = null;
      hasDiscreteGPU = true; # AMD Radeon RX 7800 XT

      wlanInterface = "wlp11s0";
      ethernetInterface = "eno1";

      # AMD k10temp: temp3 = Tctl/Tdie (CPU temperature).
      cpuHwmonPath = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
      cpuTempInput = "temp3_input";
    };

    home-manager.users.user.imports =
      (with hm; [
        cli
        de
        dev
        river
        oxbow
        eww
        syncthing
      ])
      ++ [ hm."hosts/yuki" ];

    # Do not change after the initial install. See the stateVersion option documentation.
    system.stateVersion = "26.11";
  };
}
