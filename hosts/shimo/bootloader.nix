{
  pkgs,
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
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
