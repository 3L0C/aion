{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];

  environment.systemPackages = with pkgs; [
    sbctl # Secure Boot debugging
  ];

  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";

      autoGenerateKeys.enable = true;

      autoEnrollKeys = {
        enable = true;
        includeMicrosoftKeys = true;
      };
    };
    loader = {
      # Lanzaboote replaces systemd-boot
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };
  };
}
