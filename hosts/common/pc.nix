{
  imports = [
    ./global

    ./optional/boot-quiet.nix
    ./optional/dconf.nix
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

  nix = {
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
  };
  services.dbus.implementation = "broker";
}
