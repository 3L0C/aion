# Base configuration for headless hosts (mikuru)
{config, ...}: let
  nixosModules = config.flake.modules.nixos;
in {
  flake.modules.nixos.headless = {
    config,
    lib,
    ...
  }: {
    imports = with nixosModules; [
      nh
      locate
      openssh
      tailscale
    ];

    assertions = [
      {
        assertion = config.hostSpec.kind == "headless";
        message = "headless.nix is intended for headless hosts. Got kind: ${config.hostSpec.kind}";
      }
    ];

    nix = {
      daemonCPUSchedPolicy = "batch";
      daemonIOSchedClass = "idle";
    };

    services.dbus.implementation = "broker";

    # No console on a headless server
    systemd.enableEmergencyMode = false;

    services.getty.autologinUser = lib.mkForce null;

    systemd.targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };

    boot.kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
    };

    security.pam.loginLimits = [
      {
        domain = "*";
        type = "soft";
        item = "nofile";
        value = "65536";
      }
      {
        domain = "*";
        type = "hard";
        item = "nofile";
        value = "65536";
      }
    ];
  };
}
