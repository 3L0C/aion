{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.flake-parts.flakeModules.modules];

  # flake-parts declares no merge behavior for the "lib" flake output.
  # Aspect files add helpers under flake.lib.<name>; this option lets
  # those definitions merge by key instead of colliding.
  options.flake.lib = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = {};
  };

  config.systems = ["x86_64-linux"];
}
