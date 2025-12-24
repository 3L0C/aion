{...}: {
  imports = [
    ./hardware.nix
    ../common/pc.nix
    ../common/optional/kde.nix
    ../common/users/user
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
      PasswordAuthentication = true; # Convenient for VM debugging
    };
  };

  # Open firewall for SSH
  networking.firewall.allowedTCPPorts = [22];

  system.stateVersion = "25.11";
}
