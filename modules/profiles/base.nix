{ config, ... }:
let
  nixosModules = config.flake.modules.nixos;
in
{
  flake.modules.nixos.base.imports = with nixosModules; [
    antimicrox
    bootloader
    firmware
    fonts
    hardening
    home-manager
    host-spec
    locale
    maintenance
    man
    networking
    nix
    nixpkgs-setup
    secrets
    security
    services
    ssh
    user
    version
  ];
}
