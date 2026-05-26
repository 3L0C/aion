{lib, ...}: {
  imports = [
    ./hardware.nix
    ./disks.nix
    ../common/vm.nix
    ../common/pc.nix
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
      PasswordAuthentication = lib.mkForce true; # Convenient for VM debugging
    };
  };

  # Open firewall for SSH
  networking.firewall.allowedTCPPorts = [22];
  security.pam.services = {
    greetd.rules.auth.u2f.enable = lib.mkOverride 49 false;
    swaylock.rules.auth.u2f.enable = lib.mkOverride 49 false;
  };

  system.stateVersion = "26.05";
}
