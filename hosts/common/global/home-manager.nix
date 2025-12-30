{
  inputs,
  outputs,
  config,
  secrets,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "hm-backup";
    extraSpecialArgs = {
      inherit inputs outputs secrets;
      inherit (config) hostSpec;
    };
  };
}
