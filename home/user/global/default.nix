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
      ./secrets.nix
      ./yubikey.nix
      ../features/cli/git
      ../features/cli/ssh
      ../features/cli/authinfo.nix
    ];

  inherit hostSpec;

  programs = {
    home-manager.enable = true;
  };

  home = {
    stateVersion = "26.11";
    username = "user";
    homeDirectory = "/home/${config.home.username}";
    sessionPath = ["$HOME/.local/bin"];
  };
}
