{
  config,
  lib,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  home-manager.users.user = import ../../../../home/user/${config.hostSpec.name}.nix;
  programs.zsh.enable = true;
  programs.nh.flake = "${config.users.users.user.home}/aion";
  users.groups.user = {};
  users.users.user = {
    packages = [pkgs.home-manager];
    isNormalUser = true;
    shell = pkgs.zsh;
    group = "user";
    uid = 1000;
    extraGroups =
      [
        "wheel"
      ]
      ++ ifTheyExist [
        "audio"
        "docker"
        "libvirtd"
        "media"
        "network"
        "video"
      ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIzpZTzhOr01CSn89XDn3i+L6OewOp8MTrYEQGc2SCx2"
    ];
  };
  security.pam.services = lib.mkIf (config.hostSpec.kind != "headless") {
    hyprlock = {};
    swaylock = {};
  };
}
