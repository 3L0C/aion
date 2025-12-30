{...}: {
  imports = [
    ./hardware.nix
    ../common/vm.nix
    ../common/optional/kde.nix
    ../common/optional/mate.nix
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

  system.stateVersion = "26.05";
}
