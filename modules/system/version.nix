{ inputs, ... }:
let
  aionRev = inputs.self.shortRev or inputs.self.dirtyShortRev or "dirty";
in
{
  flake.modules.nixos.version = { config, ... }: {
    system.configurationRevision = aionRev;
    system.nixos.label = "${config.system.nixos.version}_${aionRev}";
  };
}
