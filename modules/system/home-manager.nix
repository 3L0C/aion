{inputs, ...}: {
  flake.modules.nixos.home-manager = {pkgs, ...}: {
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
    };
  };
}
