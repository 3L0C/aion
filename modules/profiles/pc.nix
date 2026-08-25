# Base configuration for desktop and laptop hosts
{ config, ... }:
let
  nixosModules = config.flake.modules.nixos;
in
{
  flake.modules.nixos.pc = { config, ... }: {
    imports = with nixosModules; [
      bluetooth
      boot-quiet
      dconf
      flatpak
      games
      graphics
      greetd
      keyring
      locate
      nh
      noisetorch
      openssh
      pipewire
      pipewire-noise-cancellation
      qmk
      river
      river-uwsm
      tailscale
      thunar
      virtualization
      wayland
      wayland-sessions
      yubikey
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
  };
}
