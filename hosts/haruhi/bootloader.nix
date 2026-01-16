{
  pkgs,
  lib,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    sbctl # For debugging and troubleshooting Secure Boot
  ];

  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
