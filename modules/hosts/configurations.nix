{
  config,
  inputs,
  lib,
  ...
}:
{
  options.hosts = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options = {
          system = lib.mkOption { type = lib.types.str; };
          user = lib.mkOption {
            type = lib.types.str;
            default = "user";
          };
        };
      }
    );
    default = { };
  };

  config.flake.nixosConfigurations = lib.mapAttrs (
    name: host:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        config.flake.modules.nixos."hosts/${name}"
        inputs.home-manager.nixosModules.home-manager
        { nixpkgs.hostPlatform = host.system; }
      ];
    }
  ) config.hosts;
}
