{ ... }:
{
  imports = [
    ./bootloader.nix
    ./flatpak.nix
    ./fonts.nix
    ./hardware.nix
    ./network.nix
    ./nh.nix
    ./pipewire.nix
    ./program.nix
    ./security.nix
    ./services.nix
    ./steam.nix
    ./system.nix
    ./udev.nix
    ./user.nix
    ./virtualization.nix
    ./vpn.nix
    ./wayland.nix
    ./xserver.nix
  ];
}
