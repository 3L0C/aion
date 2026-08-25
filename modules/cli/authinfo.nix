{ inputs, ... }: {
  flake.modules.homeManager.authinfo = { config, ... }: {
    home.file.".authinfo.gpg".source =
      "${inputs.secrets.outPath}/home/${config.home.username}/authinfo.gpg";
  };
}
