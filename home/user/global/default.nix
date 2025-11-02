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
      "secrets/home/user"
    ])
    ++ [
      ../../common/themes/kanagawa.nix
      ../features/cli/common
      ../features/cli/zsh
    ];

  inherit hostSpec;

  programs = {
    home-manager.enable = true;
  };
  systemd.user.startServices = "sd-switch";

  home = {
    stateVersion = "25.11";
    username = "user";
    homeDirectory = "/home/${config.home.username}";
    sessionPath = ["$HOME/.local/bin"];
  };
}
