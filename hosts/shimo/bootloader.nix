{
  pkgs,
  lib,
  inputs,
  ...
}: {
  environment.systemPackages = [
    pkgs.sbctl # For debugging and troubleshooting Secure Boot
  ];

  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  boot.loader = {
    # Lanzaboote replaces systemd-boot
    systemd-boot.enable = lib.mkForce false;
    efi.canTouchEfiVariables = true;
  };

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
