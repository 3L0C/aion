{config, ...}: {
  imports = [
    ./global

    ./optional/bluetooth.nix
    ./optional/boot-quiet.nix
    ./optional/dconf.nix
    ./optional/flatpak.nix
    ./optional/fixes
    ./optional/graphics.nix
    ./optional/sddm.nix
    ./optional/hyprland.nix
    ./optional/keyring.nix
    ./optional/niri.nix
    ./optional/nh.nix
    ./optional/pipewire.nix
    ./optional/river.nix
    ./optional/wayland.nix
  ];
  assertions = [
    {
      assertion = config.hostSpec.kind == "desktop" || config.hostSpec.kind == "laptop";
      message = "vm.nix is intended for desktop/laptop hosts. Got kind: ${config.hostSpec.kind}";
    }
  ];

  nix = {
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
  };

  services.dbus.implementation = "broker";
}
