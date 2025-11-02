{
  config,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  home-manager.users.user =
    import ../../../../home/user/${config.hostSpec.name}.nix;
  programs.zsh.enable = true;
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
  };

  security.pam.services = {
    hyprlock = {};
  };
}
