# Base configuration for headless hosts (mikuru)
{
  config,
  lib,
  ...
}: {
  imports = [
    ./global

    ./optional/nh.nix
    ./optional/locate.nix
    ./optional/openssh-server.nix
    ./optional/tailscale.nix
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
}
