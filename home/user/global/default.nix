{
  lib,
  config,
  hostSpec,
  ...
}: {
  imports =
    (map lib.custom.relativeToRoot [
      "modules/home-manager"
      "modules/common"
    ])
    ++ [
      ./user-spec.nix
      ./sops.nix
      ./yubikey.nix
      ../features/cli/common
      ../features/cli/zsh
      ../features/cli/git
      ../features/cli/ssh
      ../features/cli/authinfo.nix
    ];

  inherit hostSpec;

  programs = {
    home-manager.enable = true;
  };
  systemd.user.startServices = "sd-switch";

  home = {
    stateVersion = "26.05";
    username = "user";
    homeDirectory = "/home/${config.home.username}";
    sessionPath = ["$HOME/.local/bin"];
  };
}
