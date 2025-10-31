{config, ...}: {
  imports = [
    ./global

    ./optional/boot-quiet.nix
    ./optional/dconf.nix
    ./optional/greetd.nix
    ./optional/hardening.nix
    ./optional/keyring.nix
    ./optional/pipewire.nix
    ./optional/wayland.nix
    ./optional/flatpak.nix
    ./optional/nh.nix
    ./optional/steam.nix
    ./optional/virtualization.nix
    ./optional/vpn.nix
    ./optional/graphics.nix
    ./optional/bluetooth.nix
    ./optional/fixes
  ];
  assertions = [
    {
      assertion = config.hostSpec.kind == "desktop" || config.hostSpec.kind == "laptop";
      message = "pc.nix is intended for desktop/laptop hosts. Got kind: ${config.hostSpec.kind}";
    }
    {
      assertion = config.hostSpec.hasDiscreteGPU -> config.hardware.graphics.enable or false;
      message = "Hosts with discrete GPUs should enable hardware.graphics";
    }
  ];

  nix = {
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
  };
  services.dbus.implementation = "broker";
}
