{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    sbctl # For debugging and troubleshooting Secure Boot
  ];
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
