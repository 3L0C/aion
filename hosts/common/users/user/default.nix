{
  config,
  lib,
  pkgs,
  inputs,
  secrets,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.mango.nixosModules.mango
  ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs lib secrets;
      inherit (config) hostSpec;
    };
    users.user = import ../../../../home/user/${config.hostSpec.name}.nix;
    backupFileExtension = "hm-backup";
  };
  programs.zsh.enable = true;
  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups =
      [
        "networkmanager"
        "wheel"
      ]
      ++ ifTheyExist [
        "audio"
        "video"
        "docker"
        "libvirtd"
      ];
    shell = pkgs.zsh;
  };

  nix.settings.allowed-users = ["user"];
}
