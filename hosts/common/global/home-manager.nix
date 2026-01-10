{
  inputs,
  outputs,
  config,
  secrets,
  pkgs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    useGlobalPkgs = true;
    # Remove any existing backup before creating new one
    backupCommand = "${pkgs.writeShellScript "hm-backup" ''
      if [[ -e "$2" ]]; then
        rm "$2"
      fi
      mv "$1" "$2"
    ''} %f %f.hm-bak";
    extraSpecialArgs = {
      inherit inputs outputs secrets;
      inherit (config) hostSpec;
    };
  };
}
