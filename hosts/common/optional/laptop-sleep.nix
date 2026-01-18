{
  config,
  lib,
  ...
}: {
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "suspend-then-hibernate";
    HandleLidSwitchDocked = "ignore";
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=2h
  '';
  security.protectKernelImage = lib.mkForce false;

  assertions = [
    {
      assertion = config.hostSpec.kind == "laptop";
      message = "laptop-sleep.nix is for laptops only";
    }
  ];
}
