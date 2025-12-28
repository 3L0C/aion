{
  pkgs,
  config,
  lib,
  ...
}: let
  shared = import ./shared.nix {inherit pkgs config lib;};
in {
  home.packages = [
    shared.wk # Plain wk with only theming and settings
    pkgs.wk-prompt
  ];
}
