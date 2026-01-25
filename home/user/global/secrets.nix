{
  inputs,
  config,
  pkgs,
  ...
}: let
  secretsDir = inputs.secrets.outPath;
in {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  home.packages = [pkgs.sops];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = "${secretsDir}/users/user/secrets.yaml";
  };
}
