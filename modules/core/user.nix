{
  pkgs,
  inputs,
  username,
  host,
  localModulesPath,
  localSecretsPath,
  localPkgsPath,
  secrets,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username host localModulesPath localSecretsPath localPkgsPath secrets; };
    users.${username} = {
      imports = [ (localModulesPath + "/home") ];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "25.11"; # TODO make this more dynamic
      programs.home-manager.enable = true;
    };
    backupFileExtension = "hm-backup";
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };
  nix.settings.allowed-users = [ "${username}" ];
}
