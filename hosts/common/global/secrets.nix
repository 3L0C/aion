{
  inputs,
  config,
  lib,
  ...
}: let
  secretsDir = toString inputs.secrets;
  hostName = config.hostSpec.name;
  normalUsers = lib.filterAttrs (_: v: v.isNormalUser) config.users.users;
  isHeadless = config.hostSpec.kind == "headless";
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  options.sops.userSecretsFile = lib.mkOption {
    type = lib.types.attrsOf lib.types.path;
    description = "Per-user paths to secrets files (accessible on all hosts)";
    readOnly = true;
  };

  config.sops = {
    defaultSopsFile = "${secretsDir}/hosts/${hostName}/secrets.yaml";
    userSecretsFile = lib.mapAttrs (name: _: "${secretsDir}/users/${name}/secrets.yaml") normalUsers;

    age = {
      sshKeyPaths = lib.mkIf isHeadless ["/etc/ssh/ssh_host_ed25519_key"];
      keyFile = lib.mkIf (!isHeadless) "/home/user/.config/sops/age/keys.txt";
    };
    secrets =
      lib.mapAttrs' (n: _: {
        name = "passwords/${n}";
        value = {
          neededForUsers = true;
        };
      })
      normalUsers;
  };
}
