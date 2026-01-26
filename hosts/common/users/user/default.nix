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
    hashedPasswordFile = config.sops.secrets."passwords/user".path;
    extraGroups =
      [
        "wheel"
      ]
      ++ ifTheyExist [
        "audio"
        "docker"
        "jellyfin"
        "libvirtd"
        "media"
        "navidrome"
        "network"
        "video"
      ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBM61uXhrZmkI+QGEboOUPnYRb1ZMM85qaYKEGeWRTTZ"
    ];
  };
  security.pam.services = lib.mkIf (config.hostSpec.kind != "headless") {
    hyprlock = {};
    swaylock = {};
  };
}
