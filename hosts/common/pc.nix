{config, ...}: {
  imports = [
    ./global

    ./optional/bluetooth.nix
    ./optional/boot-quiet.nix
    ./optional/dconf.nix
    ./optional/flatpak.nix
    ./optional/fixes
    ./optional/graphics.nix
    ./optional/greetd.nix
    ./optional/hyprland.nix
    ./optional/keyring.nix
    ./optional/nh.nix
    ./optional/pipewire.nix
    ./optional/river.nix
    ./optional/steam.nix
    ./optional/virtualization.nix
    ./optional/vpn.nix
    ./optional/wayland.nix
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
