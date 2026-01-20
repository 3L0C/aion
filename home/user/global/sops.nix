{
  inputs,
  config,
  ...
}: let
  secretsDir = toString inputs.secrets;
  inherit (config.home) username;
in {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = "${secretsDir}/users/${username}/secrets.yaml";
  };
}
