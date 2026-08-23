{
  flake.modules.nixos.secrets = {
    inputs,
    config,
    lib,
    ...
  }: let
    secretsDir = inputs.secrets.outPath;
    hostName = config.hostSpec.name;
    normalUsers = lib.filterAttrs (_: v: v.isNormalUser) config.users.users;
  in {
    imports = [inputs.sops-nix.nixosModules.sops];

    options.sops.commonSecretsFile = lib.mkOption {
      type = lib.types.path;
      description = "Path to common secrets file shared across hosts";
      readOnly = true;
    };

    config = {
      sops = {
        defaultSopsFile = "${secretsDir}/hosts/${hostName}/secrets.yaml";
        commonSecretsFile = "${secretsDir}/hosts/common/secrets.yaml";

        age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];

        # Password secrets for all normal users
        secrets =
          lib.mapAttrs' (n: _: {
            name = "passwords/${n}";
            value = {
              neededForUsers = true;
            };
          })
          normalUsers;
      };
    };
  };
}
