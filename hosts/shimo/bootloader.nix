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

  boot = {
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
}
