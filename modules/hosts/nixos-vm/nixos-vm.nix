# NixOS VM configuration for debugging
{config, ...}: let
  hm = config.flake.modules.homeManager;
in {
  hosts.nixos-vm = {
    system = "x86_64-linux";
  };

  flake.modules.nixos."hosts/nixos-vm" = {lib, ...}: {
    imports = with config.flake.modules.nixos; [
      base
      pc
      # KDE Plasma as an extra greetd session (VM-only)
      kde
    ];

    # Simple bootloader for VM (no secure boot complexity)
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Enable SSH for easy access from host
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        # mkForce: override the openssh aspect, which sets this false.
        PasswordAuthentication = lib.mkForce true; # Convenient for VM debugging
      };
    };

    # Open firewall for SSH
    networking.firewall.allowedTCPPorts = [22];

    # Disable yubikey-required PAM rules — VM has no yubikey access.
    # mkOverride 49 beats mkForce (50) in the yubikey aspect.
    security.pam.services = {
      greetd.rules.auth.u2f.enable = lib.mkOverride 49 false;
      swaylock.rules.auth.u2f.enable = lib.mkOverride 49 false;
    };

    hostSpec = {
      name = "nixos-vm";
      kind = "desktop"; # Use desktop to satisfy the pc assertions
      isWork = false;

      cpuThermalZone = null;
      hasDiscreteGPU = false; # VM uses virtual GPU
    };

    home-manager.users.user.imports =
      (with hm; [cli de dev river oxbow eww])
      ++ [hm."hosts/nixos-vm"];

    system.stateVersion = "26.11";
  };
}
