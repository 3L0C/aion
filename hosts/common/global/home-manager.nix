{
  inputs,
  outputs,
  config,
  secrets,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs secrets;
    inherit (config) hostSpec;
  };
}
