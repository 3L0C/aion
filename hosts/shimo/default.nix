{...}: {
  imports = [
    ./hardware.nix
    ./bootloader.nix
    ./ssh.nix
    ../common/headless.nix
    ../common/users/user
  ];
  system.stateVersion = "24.11";
}
